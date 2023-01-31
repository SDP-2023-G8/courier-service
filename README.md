# courier-service
This repository contains the full-stack website for the online courier service.

This web app consists of three screens:

    - The first screen displays the QR code used to authenticate the delivery 
    - The second screen is an in-browser camera for the courier to optionally take a proof of delivery image that gets uploaded to our server.
    - The third screen is a confirmation screen indicating to the courier that they can close the tab

Refer to the mock screens below for a general idea of what these screens will look like.

[Insert Image]

### 1. Use Case

The typical use case from the courier's perspective can be seen below:

1. URL contains delivery ID as query strings
2. Client script will access corresponding delivery hash for authentication from database
3. Client script renders QR code on loading of first screen
4. QR code scanning is detected and triggers database update
5. Successful scan results in camera screen
6. After (optionally) taking a picture of delivery, courier is free to close tab

### 2. Tech Stack

This repository is built on two core technologies

1. Flutter on Web
2. Firebase
