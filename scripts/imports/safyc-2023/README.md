# 19th SAFYC Regatta 2023

Official noticeboard: https://www.racingrulesofsailing.org/documents/5686/event

Sources: NOR 61857; Gold 65557, Silver 65591, ILCA 4 62698, ILCA 6 62699, ILCA 7 62700. All 19 result pages visually reviewed before secondary PDF text/position extraction. NOR page 1 verifies ILCA 1-2 April and Optimist 29-30 April at NSRCC Seasports Centre, Singapore. Saved event spans both weekends; class dates remain specific.

263 entries / 1035 scores: Gold 84, Silver 97 (3 races, zero discards); ILCA 4 60, ILCA 6 16, ILCA 7 6 (6 races, one discard). Official Silver ties at 85th and 92nd preserved. Gordon Allan's UFD codes wrap from ILCA 4 page 3 to page 4 and were manually checked. Optimist documents are labelled Final on the noticeboard, but PDF headers retain provisional status; source discrepancy preserved in evidence notes. No later results supplied by this noticeboard.

Preserve existing Optimist sheet IDs/slugs; replace their relevant entries and race scores. Add three ILCA sheets. Tan Yee Xuen (Silver sail 3001) is distinct from Tan Herng Yee (Gold sail 3000); correct mislinked Silver row. User-confirmed merged Joash and Gemma identities reused. Amos Tham / Mathias Wong / Jayden Khor variations corroborated by historical sail numbers. Yap Swee Dean is distinct from Wayne Yap Swee: official Gold lists both. Correct Dean aliases that incorrectly pointed at Wayne; historical results outside this event require separate review.

Uncertain pairs remain distinct: Ethan Teo Yuan Xin / Ethan Teo; Fang Si Wei Hayley / Hayley Fang; Samuel Tan Hsien Ern / Samuel Tan Hsien Wen; Edward Charles O'Shea / O'Shea Edward; Zachary Khoo Shi Jay / Zachary Khoo; Omar Aguer / Omar Agoes. Ezann Sephira Tan remains distinct from the combined crew record Nicole Ng / Ezann Sephira Tan.

Existing sailor profile metadata remains unchanged. Original PDFs and pre-import backup are kept in ignored artifacts/imports/safyc-2023. Import SQL is an atomic data replacement, not a schema migration; validations check each score sum, net, race count, discard count, and class entry count.

Additional review: Leopold Sayawaki-Kogut is aliased to Sumire Sayawaki-Kogut (same sail 710, conflicting source name and gender). Import uses a distinct Leopold record pending confirmation. Asher Pon Sheng Rui's existing alias and sail 3507 match Sheng Rui Li; retain that link but flag the canonical name. Mathias Yu Da Wong / Mahias Wong remains a possible duplicate requiring confirmation.

Administrator subsequently confirmed all supplied results final and authorized six identity merges; see confirmed-six-merges.sql and the decisions in name-review.md. Dry run and live verification passed. Source header text remains historical evidence; finality in result notes now reflects administrator confirmation. Leopold/Sumire, Ange/Angel, Omar Aguer/Omar Agoes remain separate by explicit instruction.
