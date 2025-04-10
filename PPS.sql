CREATE DATABASE IF NOT EXISTS PetPals;
USE PetPals;

CREATE TABLE IF NOT EXISTS Shelters (
    ShelterID INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Users (
    UserID INT PRIMARY KEY,
    Name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Pets (
    PetID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Breed VARCHAR(100),
    Type VARCHAR(50),
    AvailableForAdoption BIT,
    OwnerID INT,
    ShelterID INT,
    FOREIGN KEY (OwnerID) REFERENCES Users(UserID),
    FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID)
);

CREATE TABLE IF NOT EXISTS Donations (
    DonationID INT PRIMARY KEY,
    DonorName VARCHAR(100),
    DonationType VARCHAR(50),
    DonationAmount DECIMAL(10,2),
    DonationItem VARCHAR(100),
    DonationDate DATETIME,
    ShelterID INT,
    FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID)
);

CREATE TABLE IF NOT EXISTS AdoptionEvents (
    EventID INT PRIMARY KEY,
    EventName VARCHAR(100),
    EventDate DATETIME,
    Location VARCHAR(100)
);


CREATE TABLE IF NOT EXISTS Participants (
    ParticipantID INT PRIMARY KEY,
    ParticipantName VARCHAR(100),
    ParticipantType VARCHAR(50),
    EventID INT,
    Location VARCHAR(100), -- 🔥 Location added here
    FOREIGN KEY (EventID) REFERENCES AdoptionEvents(EventID)
);


INSERT INTO Shelters VALUES
(1, 'Happy Tails Shelter', 'Chennai'),
(2, 'Paws and Claws', 'Bangalore'),
(3, 'Furry Friends', 'Mumbai');

INSERT INTO Users VALUES
(1, 'Srinidhi'),
(2, 'Mickey'),
(3, 'Nidhi'),
(4, 'Sri');

INSERT INTO Pets VALUES
(1, 'Alpha', 2, 'Labrador', 'Dog', 1, NULL, 1),
(2, 'Genny', 5, 'Beagle', 'Dog', 1, NULL, 1),
(3, 'Luna', 1, 'Persian', 'Cat', 0, 1, 2),
(4, 'Melon', 6, 'Bulldog', 'Dog', 1, NULL, 2),
(5, 'Luca', 3, 'Pug', 'Dog', 0, 2, 2),
(6, 'Coco', 2, 'Maine Coon', 'Cat', 1, NULL, 3),
(7, 'Bunny', 7, 'Golden Retriever', 'Dog', 1, NULL, 3),
(8, 'Angle', 4, 'Siamese', 'Cat', 0, 3, 1),
(9, 'Rocky', 8, 'German Shepherd', 'Dog', 1, NULL, 1),
(10, 'Panda', 2, 'Persian', 'Cat', 0, 4, 2);

INSERT INTO Donations VALUES
(1, 'Ram', 'Cash', 5000.00, NULL, '2024-01-15', 1),
(2, 'Karun', 'Item', NULL, 'Pet Food', '2024-02-20', 1),
(3, 'Angelin', 'Cash', 3000.00, NULL, '2024-01-05', 2),
(4, 'Jokiee', 'Item', NULL, 'Blankets', '2024-03-01', 3);

INSERT INTO AdoptionEvents VALUES
(1, 'Adoptathon', '2024-03-10 10:00:00', 'Chennai'),
(2, 'Paws Fest', '2024-04-05 15:00:00', 'Bangalore');


INSERT INTO Participants VALUES
(1, 'Happy Tails Shelter', 'Shelter', 1, 'Chennai'),
(2, 'Srinidhi', 'Adopter', 1, 'Chennai'),
(3, 'Mickey', 'Adopter', 2, 'Bangalore');

DELETE FROM Shelters;

INSERT INTO Shelters VALUES
(1, 'Happy Tails Shelter', 'Chennai'),
(2, 'Paws and Claws', 'Bangalore'),
(3, 'Furry Friends', 'Mumbai');


