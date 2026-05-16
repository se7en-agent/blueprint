const REVIEW_PATTERNS = [
  /writeback review/i,
  /writeback\s*:/i,
  /memory.*wiki.*story.*blueprint.*profile/is,
];

function isEnabled(config) {
  return config?.enabled !== false;
}

function hasWritebackReview(text) {
  const body = String(text || "");
  return REVIEW_PATTERNS.some((pattern) => pattern.test(body));
}

export default {
  id: "se7en-writeback-guard",
  name: "Se7en Writeback Guard",
  description: "Ensures final answers include a writeback review before finalization.",
  register(api) {
    api.on(
      "before_agent_finalize",
      async (event, ctx) => {
        if (!isEnabled(ctx?.pluginConfig)) return;

        if (hasWritebackReview(event?.lastAssistantMessage)) {
          return { action: "continue" };
        }

        return {
          action: "revise",
          reason: "The final answer does not include a writeback review.",
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
  },
};
