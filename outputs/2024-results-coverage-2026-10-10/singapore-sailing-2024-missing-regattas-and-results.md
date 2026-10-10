# Missing 2024 Singapore Sailing Regattas and Results in SailorPath

Singapore Sailing’s official 2024 Results archive contains **18 regatta groups** and **44 linked result documents**. After reconciling every group against the SailorPath production `regatta_events`, normalized result sheets, race rows, and live WingFoil/Techno 293 APIs, **six official regatta groups are absent entirely**. A seventh event is only partially represented. [1]

## Missing regattas and results

- **CSC ILCA Open & 29er Open** — **13–14 January 2024, Changi Sailing Club**. SailorPath has neither a calendar event nor result sheets for **ILCA 4**, **ILCA 6**, or **29er**. This is a complete missing-event import. [1] [2]

- **RM ILCA Championship** — **23–24 March 2024, Raffles Marina**. SailorPath has neither the regatta event nor **ILCA 4** and **ILCA 6** result sheets. Do not substitute the similarly named 2025 Raffles Marina ILCA event. [1] [3]

- **47th Singapore ILCA Open** — **7–8 December 2024**. SailorPath has neither the calendar event nor the official **ILCA 4**, **ILCA 6**, and **ILCA 7** results. [1] [4]

- **2024 NorthEast Monsoon Grand Prix**. The official archive has separate **Techno 293**, **WindFoil**, and **WingFoil** results. SailorPath has no matching 2024 event and no matching result in either normalized board sheets or the public specialist scorecard APIs. The archive does not expose a reliable race-date range, so the import should retain the official source metadata instead of inferring dates. [1]

- **2024 National Slalom** — **17–18 February 2024, Changi Beach Carpark 1**. SailorPath is missing the event and the combined official results for **Slalom**, **Wingfoil**, and **Techno 293**. [1] [5]

- **2024 SG Foil Grand Prix Series**. SailorPath is missing the event and the final series results for **Techno 293**, **WindFoil**, and **WingFoil**. The official schedule identifies four August–September 2024 rounds, and the final result documents were published on 17 December. [1] [6]

## Partially missing

- **Singapore Youth Sailing Championships 2024** is already a SailorPath calendar event and has published result sheets for Optimist Gold/Silver, ILCA 4, ILCA 6, 29er, Techno 293, and iQFOiL. However, the official combined document also includes **ILCA 7**, and SailorPath has no matching 2024 ILCA 7 sheet. Import **one ILCA 7 result sheet** and attach it to the existing event rather than creating a duplicate event. [1]

## Calendar event missing, but result already exists

- **CSC Optimist Championship (Gold), 20–21 January 2024** has a published SailorPath Optimist Gold result sheet (`CSC Gold (Jan 24)`), but no corresponding 2024 calendar/event record. Create the calendar event and link the existing Gold result sheet; do **not** re-import the standings. [1]

## Already covered completely

No import is needed for these official archive groups: 20th SAFYC Regatta (Optimist), 20th SAFYC Regatta (Dinghy), Raffles Marina Optimist Regatta, RSYC Optimist Silver Fleet Knockout Championship, RSYC Optimist Gold Fleet Knockout Championship, Singapore National Sailing Championships, NSC Cup II, NSC Cup I, CSC Optimist Championship (Silver), and Pesta Sukan.

The production reconciliation confirms that the following commonly misclassified groups are already covered:

- **SYSC 2024** already has 29er, Techno 293, and iQFOiL results; only ILCA 7 is missing.
- **Singapore National Sailing Championships 2024** already has Optimist Gold/Silver, ILCA 4/6/7, 29er, Techno 293, Windfoil, and Windsurfing LT results.
- **Raffles Marina Optimist Regatta 2024** and **CSC Optimist Championship (Silver) 2024** already have both event and result records.

## Import backlog

The actionable backlog is therefore:

1. Create and import **six complete missing regatta groups** with **17 missing official fleet-result sets**.
2. Import **one ILCA 7 sheet** into the existing SYSC 2024 event.
3. Create and link the existing **CSC Optimist Gold 2024** calendar event.

For every result import, preserve the official document URL and follow the repository rule to render and visually validate each supplied PDF table before transcribing scores, discards, totals, nett scores, and participant metadata.

**References**

[1]: https://www.sailing.org.sg/results "Singapore Sailing Results archive"

[2]: https://drive.google.com/file/d/1viZxFwXrdLyWWfYMQ3EGX_Tfpr0uBvhl/view?usp=drive_link "CSC ILCA 29er Championships 2024 — ILCA 4 official results"

[3]: https://www.rafflesmarina.com.sg/happenings/rm-ilca-2024.html "Raffles Marina ILCA Championship 2024"

[4]: https://www.racingrulesofsailing.org/documents/9981/event "47th Singapore ILCA Open 2024 official event record"

[5]: https://drive.google.com/file/d/1DY4o7fJfFF6-uqjY5cb-L-g_oLnVu5EK/view?usp=sharing "2024 National Slalom official results"

[6]: https://singaporesailing.eventsmart.com/events/2024-sg-foil-gp/ "2024 SG Foil Grand Prix Series official event page"
