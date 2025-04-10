SELECT Name, Age, Breed, Type
FROM Pets
WHERE AvailableForAdoption = 1;


SELECT ParticipantName, ParticipantType
FROM Participants
WHERE EventID = 1; 

SELECT s.Name AS ShelterName, 
       IFNULL(SUM(d.DonationAmount), 0) AS TotalDonations
FROM Shelters s
LEFT JOIN Donations d ON s.ShelterID = d.ShelterID
GROUP BY s.ShelterID, s.Name;


SELECT Name, Age, Breed, Type
FROM Pets
WHERE OwnerID IS NULL;


SELECT 
    YEAR(DonationDate) AS Year,
    MONTH(DonationDate) AS Month,
    DATE_FORMAT(DonationDate, '%M %Y') AS MonthYear,
    SUM(IFNULL(DonationAmount, 0)) AS TotalAmount
FROM Donations
GROUP BY 
    YEAR(DonationDate),
    MONTH(DonationDate),
    MonthYear
ORDER BY 
    YEAR(DonationDate), 
    MONTH(DonationDate);

SELECT DISTINCT Breed
FROM Pets
WHERE (Age BETWEEN 1 AND 3) OR Age > 5;


SELECT p.Name AS PetName, s.Name AS ShelterName
FROM Pets p
JOIN Shelters s ON p.ShelterID = s.ShelterID
WHERE p.AvailableForAdoption = 1;

SELECT COUNT(*) AS TotalParticipants
FROM Participants p
JOIN AdoptionEvents e ON p.EventID = e.EventID
JOIN Shelters s ON s.Name = p.ParticipantName AND p.ParticipantType = 'Shelter'
WHERE e.Location = 'Chennai';


SELECT DISTINCT Breed
FROM Pets
WHERE Age BETWEEN 1 AND 5;

SELECT *
FROM Pets
WHERE AvailableForAdoption = 1;

SELECT p.Name AS PetName, u.Name AS AdopterName
FROM Pets p
JOIN Users u ON p.OwnerID = u.UserID
WHERE p.OwnerID IS NOT NULL;

SELECT s.Name AS ShelterName, COUNT(p.PetID) AS AvailablePets
FROM Shelters s
LEFT JOIN Pets p ON s.ShelterID = p.ShelterID AND p.AvailableForAdoption = 1
GROUP BY s.ShelterID, s.Name;

SELECT p1.Name AS Pet1, p2.Name AS Pet2, p1.Breed, s.Name AS Shelter
FROM Pets p1
JOIN Pets p2 ON p1.ShelterID = p2.ShelterID 
            AND p1.Breed = p2.Breed 
            AND p1.PetID < p2.PetID
JOIN Shelters s ON p1.ShelterID = s.ShelterID;

SELECT s.Name AS ShelterName, e.EventName
FROM Shelters s
CROSS JOIN AdoptionEvents e;

SELECT s.Name AS ShelterName, COUNT(p.PetID) AS AdoptedPets
FROM Shelters s
JOIN Pets p ON s.ShelterID = p.ShelterID
WHERE p.OwnerID IS NOT NULL
GROUP BY s.ShelterID, s.Name
ORDER BY AdoptedPets DESC
LIMIT 1;


DELETE FROM Shelters;
INSERT INTO Shelters VALUES
(1, 'Happy Tails Shelter', 'Chennai'),
(2, 'Paws and Claws', 'Bangalore'),
(3, 'Furry Friends', 'Mumbai');

DELIMITER //

CREATE PROCEDURE UpdateShelterInfo (
    IN p_ShelterID INT,
    IN p_NewName VARCHAR(100),
    IN p_NewLocation VARCHAR(100)
)
BEGIN
    DECLARE shelterExists INT;

    -- Check if the shelter exists
    SELECT COUNT(*) INTO shelterExists
    FROM Shelters
    WHERE ShelterID = p_ShelterID;

    IF shelterExists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Shelter ID does not exist.';
    ELSE
        -- Update the shelter details
        UPDATE Shelters
        SET Name = p_NewName,
            Location = p_NewLocation
        WHERE ShelterID = p_ShelterID;
    END IF;
END //

DELIMITER ;

SELECT * FROM Shelters;
