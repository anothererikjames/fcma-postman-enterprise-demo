# API Change Summary

<!-- What contract change does this PR make, and why? -->

## Consumer Impact

**Who consumes this API?**

<!-- List internal teams, partner integrations, and downstream systems affected.
     Is this change backward compatible? If not, what is the migration path? -->

## Contract Checklist

- [ ] Operation summaries and descriptions are complete
- [ ] `X-Correlation-Id` header is included on every operation
- [ ] `401` and `403` responses are defined on secured operations
- [ ] All 4xx/5xx responses use the `StandardError` schema
- [ ] Every 200 response includes examples
- [ ] List endpoints return the standard pagination envelope
- [ ] Postman collection regenerated/reviewed for this change
- [ ] Mock examples updated (if partner-facing behavior changed)

## Validation

- [ ] API Governance check passed (`npm run lint:customer` / Actions: API Governance)
- [ ] Contract Conformance check passed (if applicable)
