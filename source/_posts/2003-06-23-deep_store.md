---
layout: post
title: "'Deep Store' project attracts government and industry funding to address data storage problems"
author: Tim Stephens
images:
  -
    - file: ../art/d_long.03-06-23.155.jpg
    - caption: "Darrell Long, professor of computer science, is lead investigator on the Deep Store project."
---

UCSC computer scientists are developing a new approach to online "deep storage" of digital data that promises to have many advantages over traditional backup and archival storage methods. The Deep Store project has been awarded a $205,000 grant from the National Science Foundation, and has received significant gift support from the research divisions of Hewlett-Packard and Microsoft.

Managing the rapidly increasing volume of digital reference data is a growing problem for companies and institutions, said Darrell Long, professor of computer science and lead investigator on the Deep Store project.   

"We're looking at the problem of managing data that doesn't go away--things like medical records, financial records, and other kinds of documents that, in many cases, companies need to keep for regulatory reasons," Long said.   

These kinds of data are known as fixed content: documents, e-mail, images, and audiovisual data that are kept as a reference for future use. While the volume of such data has been increasing dramatically, users are also beginning to demand quick and easy access to their stored data, said Lawrence You, a graduate student working with Long on the Deep Store project.   

The traditional media for archival storage--magnetic tape and optical disks--do not allow fast online access to stored data. Hard disk drives offer high speed and random access to data, and they are already used in various nonarchival storage systems, such as "storage area networks" and "network-attached storage." Disk-based online storage systems are also available for managing and archiving fixed content (e.g., the Centera system from EMC Corp.), but this is still an expensive option compared to tape-based storage, You said.   

"Currently, most archival storage uses magnetic tape. We want to create a disk-based storage system that can replace the traditional archival medium of tape," You said.   

"The main drawback of tape-based storage is slow access, and in addition tape only lasts five to 15 years," he said. "With disks you can run reliability tests in the background, whereas with a tape you don't know if it's still good until you try to read the data on it."  

The cost advantage of magnetic tape as a storage medium has been greatly diminished in recent years due to rapidly falling prices for hard disk drives. By using high rates of data compression to increase storage density, You and Long think their Deep Store system can be both faster and cheaper than tape-based systems.  

A lot of fixed-content data exists in multiple versions that contain similar information, such as credit card data in which all the records for a given account contain the same account information. Long has done pioneering work on a technique called delta compression (also called differential compression) that takes advantage of this redundancy. If a file to be stored is similar to one that has already been stored, delta compression encodes the second file as edits of the first file, which can yield tremendous space savings.   

The challenge is designing a software program that can locate similar files within a huge volume of stored data.  

"That's going to be the hard part," said You. "I have this little file that I want to store, and I have to find something that looks like it in this huge amount of stored data. It's like looking for a needle in a haystack, except that I want to find another needle that looks a bit like the one I've got."  

Organizing the data in the deep store so that similar files are associated for efficient storage and retrieval is the current focus of You's work. The process will involve extracting summary data from new files as they are stored, so that searches can be done by comparing summaries rather than searching file by file, You said.   

Another important consideration is to create a scalable architecture for the deep store system, so that the storage capacity will be virtually unlimited. Large companies and institutions will soon require systems capable of storing petabytes of fixed-content data (a petabyte is roughly one million gigabytes).  

The increasing use of digital images and audiovisual files is one factor behind the increasing volume of fixed-content data. Medical imaging, for example, generates huge image files.   

Regulatory changes are also having a tremendous impact, Long said. The heavily regulated health care, finance, and defense industries, for example, are among the biggest consumers of computer storage systems, as companies seek to comply with new regulations for retention of electronic records. Scientific research is another area in which extremely large data sets are being generated, especially in fields such as astronomy and high-energy physics.  

"Online Deep Stores are a solution to these growing data storage needs," You said.  

Industry support for the Deep Store project includes $35,000 from Microsoft Research and $45,000 from HP Labs. An additional $55,000 in equipment from HP Labs will be used to build a 16-processor cluster machine with 2.5 terabytes of storage space, Long said. The funding and equipment from HP Labs was provided through UCSC's partnership in the Center for Information Technology Research in the Interest of Society (CITRIS).  

[source](http://www1.ucsc.edu/currents/02-03/06-23/deep_store.html "Permalink to deep_store")
