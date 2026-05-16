const STATEFUL_TOOL_PATTERNS = [
  /apply_patch/i,
  /(^|_)write($|_)/i,
  /(^|_)edit($|_)/i,
  /(^|_)exec($|_)/i,
  /process/i,
  /shell/i,
  /terminal/i,
  /cron/i,
  /task/i,
  /github/i,
  /git/i,
  /message/i,
  /slack/i,
  /email/i,
  /deploy/i,
  /publish/i,
];

const REVIEW_PATTERNS = [
  /writeback review/i,
  /writeback\s*[:：]/i,
  /回写评估/,
  /写回评估/,
  /是否.*wiki.*story/i,
  /memory.*wiki.*story.*blueprint.*profile/is,
];

const activeRuns = new Map();

function runKey(event, ctx) {
  return event?.runId || ctx?.runId || event?.sessionId || ctx?.sessionKey || "unknown";
}

function isEnabled(config) {
  return config?.enabled !== false;
}

function isStatefulTool(toolName) {
  const text = String(toolName || "");
  return STATEFUL_TOOL_PATTERNS.some((pattern) => pattern.test(text));
}

function hasWritebackReview(text) {
  const body = String(text || "");
  return REVIEW_PATTERNS.some((pattern) => pattern.test(body));
}

export default {
  id: "se7en-writeback-guard",
  name: "Se7en Writeback Guard",
  description: "Ensures state-changing turns include a writeback review before finalization.",
  register(api) {
    api.on(
      "before_tool_call",
      async (event, ctx) => {
        if (!isEnabled(ctx?.pluginConfig)) return;
        if (!isStatefulTool(event?.toolName)) return;

        const key = runKey(event, ctx);
        activeRuns.set(key, {
          toolName: String(event?.toolName || "unknown"),
          markedAtMs: Date.now(),
        });
      },
      { priority: 100 },
    );

    api.on(
      "before_agent_finalize",
      async (event, ctx) => {
        if (!isEnabled(ctx?.pluginConfig)) return;

        const key = runKey(event, ctx);
        const marker = activeRuns.get(key);
        if (!marker) return;

        if (hasWritebackReview(event?.lastAssistantMessage)) {
          activeRuns.delete(key);
          return { action: "continue" };
        }

        return {
          action: "revise",
          reason: "State-changing work was performed, but the final answer does not include a writeback review.",
          retry: {
            idempotencyKey: "se7en-writeback-review",
            maxAttempts: 1,
            instruction:
              "Before finalizing, add a concise 'Writeback Review' section. State whether memory, wiki, story, blueprint, and profile should be updated. If no update is needed for a target, say so. Keep it short and do not reveal secrets.",
          },
        };
      },
      { priority: 100, timeoutMs: 3000 },
    );

    api.on("agent_end", async (event, ctx) => {
      const key = runKey(event, ctx);
      activeRuns.delete(key);
    });
  },
};
