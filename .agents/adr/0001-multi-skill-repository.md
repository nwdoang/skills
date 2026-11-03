# ADR 0001: Use a Multi-Skill Repository

## Status

Accepted

## Context

Reusable agent behaviors need a public home that can grow beyond a single skill without coupling their instructions or importing private project details.

## Decision

This repository will contain multiple independently structured personal/public skills. Context Perimeter is the first engineering skill. Generic, reusable behaviors belong here; company-specific or private skills do not automatically belong here.

## Consequences

Each skill owns its instructions and metadata while shared maintenance rules stay at the repository root. Repository infrastructure will grow only when actual usage justifies it.
