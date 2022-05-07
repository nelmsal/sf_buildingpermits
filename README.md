# Housing Permit Metrics of San Francisco
*CPLN 680 Capstone* <br>by Alexander Nelms

## Deliverables
| Date | Project | Location |
| :---: | :--- | :---: |
| Jan 21 | **Project Proposal 0** | [*PDF*](https://github.com/CPLN-680-Spring-2022/Nelms_Alex_BuildingPermits/blob/main/deliverables/Nelms%20-%20Project%20Proposal%200.pdf) |
| Feb 11 | **Summary Presentation** | [*Google Slides*](https://docs.google.com/presentation/d/1N7rwu2h_tOyCqjYUjLAdrQE9qGC5Ub88AGJ2C4VMKzw/edit?usp=sharing) |
| Feb 18 | **Project Proposal 1** | [*PDF*](https://github.com/CPLN-680-Spring-2022/Nelms_Alex_BuildingPermits/blob/main/deliverables/Nelms%20-%20Project%20Proposal%201.pdf) |
| Mar 4 | **Work in Progress Report** | [*PDF*](https://github.com/CPLN-680-Spring-2022/Nelms_Alex_BuildingPermits/blob/main/deliverables/Nelms%20-%20Work%20in%20Progress%20Report.pdf) |
| Mar 25 | **Mid-Point Presentation** | [*Slides*](https://docs.google.com/presentation/d/1W1AoLwwzns3m4JJcWKHuaKogv6Pc1gcwluKkO7m-1Jo/edit?usp=sharing), [*PDF*](https://github.com/CPLN-680-Spring-2022/Nelms_Alex_BuildingPermits/blob/main/deliverables/CPLN%20680%20-%20Nelms%20-%20Permit%20Metrics%20-%20Mid-Point%20Presentation.pdf) |
| Mar 25 | **Peer Review** - Hanyu Gao | [*doc*](https://github.com/CPLN-680-Spring-2022/Nelms_Alex_BuildingPermits/blob/811edbd7870a022d6faa57cec041a0fcf01fd390/deliverables/Nelms%20-%20Midpoint%20Peer%20Review%20-%20Hanyu%20Gao.docx) |
| Mar 25 | **Peer Review** - Hanpu Yao | [*doc*](https://github.com/CPLN-680-Spring-2022/Nelms_Alex_BuildingPermits/blob/811edbd7870a022d6faa57cec041a0fcf01fd390/deliverables/Nelms%20-%20Midpoint%20Peer%20Review%20-%20Hanpu%20Yao.docx) |
|*Final Report*|
| Apr 29 | **Final Report** | [*html*](https://github.com/CPLN-680-Spring-2022/Nelms_Alex_BuildingPermits/blob/main/deliverables/PermitMetrics_FinalReport.html) |
| Apr 29 | Extra: **Data Cleaning Report** | [*ipynb*](https://github.com/CPLN-680-Spring-2022/Nelms_Alex_BuildingPermits/blob/main/scripts/python/sf_buildingpermit_import.ipynb) |
| Apr 29 | Extra: **Permit Web Map** | [*repository*](https://github.com/nelmsal/sf-building-permits-web-map) |

## Question
1. How long does it takes to obtain a residential building construction permit for the cities of San Francisco, Berkeley, & Walnut Creek?
* with how many Total Days, Working Days, Re-Submittals, & Public Hearings needed?

2. How much does the approval and permitting time vary depending on the:
  A. Building Characteristics,
  B. The Community's Demographics & Economic Factors, or
  C. Public Body Approval?

## Final Deliverable
2. A Report analyzing the statistical & spatial differences in permits

## Background
Building Construction Permits can be notoriously difficult to receive due to the lengthy administrative & political system and policies. The public hearing bodies that approve permits & provide transparency to the process, have become bottlenecks for approval. The San Francisco Bay area is empirically known for its long permitting process & notorious unapprovals. The slow permit process has been one of the factors leading up to the area's housing crisis.

The permitting process has largely gone under-researched. Because local government typically has suffered from siloed data, overworked permitting systems, and data illiteracy, it is difficult to get accurate measurements of the permitting process. Without this data, it is difficult to use statistical or spatial analysis to isolate the leading factors of the permitting process.

Because of my work with Walnut Creek, I have already created Python scripts that pull permit timelines from Accela, process each task into time measurements, then aggregate them.  Luckily, many West Coast cities contract Accela to manage their permitting system through software and structured data. So expanding the scope of this analysis into other Bay Area cities wouldn't be as difficult.
