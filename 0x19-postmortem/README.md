Payee Service Outage

Issue Summary

On June 1, 2024, from 14:00 to 18:00 GMT, the payee registration and login services became unavailable to 70% of their user base. New users couldn’t register or log in if they already had an account. It was an issue of database lock-up because of an unexpectedly high number of concurrent transactions happening at the same time, along with a missing database index on a commonly queried column.

Timeline

- 14:00 GMT — Issue identified through an automated monitoring alert showing elevated error rates for the registration and login services.
- 14:05 GMT — Reported to the Engineering team, which started initial research.
- 14:10 GMT — Confirmed user-reported failures to register/log in.
- 14:20 GMT — A more detailed investigation started by the database team to explore the potential cause, focusing on connection problems.
- 14:30 GMT— Suspected network latency issue; cross-verified with the network team, no issue reported.
- 15:00 GMT— Misleading path; suspect that recent deployment can be the cause, roll back to last-known version, but still, the issue prevailed.
- 16:00 GMT — Deep diving into database logs showed a warning related to deadlock and slow queries.
- 16:30 GMT — The incident was further escalated to the database architecture team for a more in-depth investigation.
- 17:00 GMT — Identified missing index on the `email` column of the `users` table, leading to deadlocks at high loads.
- 17:30 GMT — Created and applied missing index.
- 18:00 GMT — Full recovery in services, and error rates are back to normal.

Root Cause and Resolution

Root Cause

A high number of requests were being generated from both Registration and Payee services, resulting in a spike in this service. There was no index on the `email` column of the most used `users` table. This caused extreme slowness in query performance, which, reciprocally, caused transaction deadlocks and failures of service.

Resolution

When it was understood that the missing index was actually the problematic root cause, the database team proceeded with the building of an index on the `email` table column and applied it. This optimization cut down the query time, consequently removing deadlocks and restoring the service in function.

Improvements to Corrective and Preventative Measures

- Improve database indexing strategy with regular audits and performance testing to identify and fix potential bottlenecks.
- More rigorous monitoring and alerting for database performance metrics, i.e., the execution time of queries and detector cases for deadlocks.
- Develop and implement automated scripts to detect and resolve common database issues, e.g., missing indexes.

Tasks

1. Audit current database indexes. Optimize them where needed.
2. Monitoring Enhancements
— Add query execution time alerts.
— Monitor deadlock events and other important database performance indicators.
3. Automated Index Suggestion Tool: Develop a tool that can periodically analyze query patterns and suggest required indexes.
4. Load Testing: Do periodic load testing to simulate high traffic and identify potential performance hardships.
5. Deploy Update Process: Ensure that performance considerations are made with every change to the database and that these are reviewed by the database architecture team when deploying an update.
6. Training: Train engineering teams on database optimization and troubleshooting.

While this postmortem is supposed to get a clear understanding of the outage, the steps taken to resolve it are, foremost, a measure that we plan to implement to avoid such a situation in future occurrences. We hope that the resolution of these issues proactively shall enable us to secure the Payee service toward guaranteed stability and reliability.


