#!/bin/bash
set -e
cargo build --target aarch64-apple-darwin
swiftc -L target/aarch64-apple-darwin/debug/ -lswift_tokenizers -import-objc-header bridging-header.h \
  -lc++ \
  main.swift ./generated/swift-tokenizers/swift-tokenizers.swift ./generated/SwiftBridgeCore.swift
