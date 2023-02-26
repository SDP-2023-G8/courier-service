# courier-service
This repository contains the full-stack website for the online courier service.

This web app consists of three screens:

- The first screen displays the QR code used to authenticate the delivery 
- The second screen is an in-browser camera for the courier to optionally take a proof of delivery image that gets uploaded to our server.
- The third screen is a confirmation screen indicating to the courier that they can close the tab

Refer to the mock screens below for a general idea of what these screens will look like.

![image](https://user-images.githubusercontent.com/34693834/216079687-696b8dff-d17b-43a2-8b1a-7ecf6d725276.png)

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
2. MongoDB

### 3. Usage

In order to run the application, you will first have to check that chrome (web) is listed as one of the flutter devices by running 

```
flutter devices
```

If you have Chrome installed, this device should appear in this list.

After ensuring the device is available, you can run the following command to execute the application locally:

```
flutter run -d chrome --dart-define=API_HOST=<api_hostname:port>
```

This will open a terminal session that supports hot restarting for development purposes (hot reload not currently supported by Flutter Web).

Note that you can pass environment variables using --dart-define to specify the REST-API hostname and port. If not specified, this will default to `localhost:5000`.

Note also, that if chrome does not appear as one of your devices, you can run the application using flutter's development web server:

```
flutter run -d web-server --dart-define=API_HOST=<api_hostname:port>
```

Note that if running locally, you must have an instance of the REST-API running on your machine. See the README on the InBoX-REST repo for instructions on how to set that up.

### 4. QR Code Details

In the current implementation, the QR code is generated from a string in the format `deliveryID+hashCode` where deliveryID uniquely identifies a delivery in the Firestore Cloud database and hashCode refers to an MD5 hash stored as a field under that delivery's record.

### 5. REST-API

As mentioned above, the courier service app relies on communication to our internal REST-API. If not using a local instance of this API, you must specify the hostname and port of the API using the --dart-define flag.
