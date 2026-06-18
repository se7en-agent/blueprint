#!/usr/bin/env python3
import argparse
import os
from pathlib import Path

from faster_whisper import WhisperModel


def main():
    parser = argparse.ArgumentParser(description="Small Whisper-compatible CLI backed by faster-whisper")
    parser.add_argument("--file", required=True)
    parser.add_argument("--model", default="tiny")
    parser.add_argument("--language", default=None)
    parser.add_argument("--output-dir", default=None)
    parser.add_argument("--output-format", default="txt")
    args = parser.parse_args()

    # CPU int8 keeps memory/cold-start modest on the gateway host.
    model = WhisperModel(args.model, device="cpu", compute_type="int8")
    segments, info = model.transcribe(args.file, language=args.language, vad_filter=True)
    text = " ".join(seg.text.strip() for seg in segments).strip()

    if args.output_dir:
        out_dir = Path(args.output_dir)
        out_dir.mkdir(parents=True, exist_ok=True)
        out_path = out_dir / (Path(args.file).stem + "." + args.output_format)
        out_path.write_text(text + ("\n" if text else ""), encoding="utf-8")

    print(text)


if __name__ == "__main__":
    main()
