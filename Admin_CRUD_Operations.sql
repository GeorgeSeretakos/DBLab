SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- GET PROCEDURES
DELIMITER $$

DROP PROCEDURE IF EXISTS GetAllChefs$$
CREATE PROCEDURE GetAllChefs(IN p_UserID INT)
BEGIN
	DECLARE v_Role VARCHAR(255);
    SELECT Role INTO v_Role FROM User WHERE ID_User = p_UserID;

    IF v_Role = 'Admin' THEN
		SELECT
			c.ID_Chef,
			c.First_Name,
			c.Last_Name,
			u.Username,
			u.Password,
			c.Phone_Number,
			c.Birthdate,
			c.Age,
			c.Years_of_Experience,
			c.Specialization,
			GROUP_CONCAT(nc.Name ORDER BY nc.Name SEPARATOR ', ') AS National_Cuisines,
			c.Photo,
			c.Photo_Description
		FROM Chef c
		JOIN User u ON c.ID_Chef = u.ID_Chef
		JOIN National_Cusine_Chef AS ncc ON c.ID_Chef = ncc.ID_Chef
		JOIN National_Cusine nc ON ncc.ID_National_Cusine = nc.ID_National_Cusine
		GROUP BY c.ID_Chef
		ORDER BY c.ID_Chef;
	ELSE
        SELECT 'Access Denied. You do not have permission to delete steps from this recipe.';
	END IF;
END$$


DROP PROCEDURE IF EXISTS GetNationalCusine$$
CREATE PROCEDURE GetNationalCusine()
BEGIN
    SELECT * FROM National_Cusine;
END$$


DROP PROCEDURE IF EXISTS GetMeal$$
CREATE PROCEDURE GetMeal()
BEGIN
    SELECT * FROM Meal;
END$$


DROP PROCEDURE IF EXISTS GetTags$$
CREATE PROCEDURE GetTags()
BEGIN
    SELECT * FROM Tags;
END$$


DROP PROCEDURE IF EXISTS GetEquipment$$
CREATE PROCEDURE GetEquipment()
BEGIN
    SELECT * FROM Equipment;
END$$


DROP PROCEDURE IF EXISTS GetFoodCategory$$
CREATE PROCEDURE GetFoodCategory()
BEGIN
    SELECT * FROM Food_Category;
END$$


DROP PROCEDURE IF EXISTS GetThematicUnit$$
CREATE PROCEDURE GetThematicUnit()
BEGIN
    SELECT * FROM Thematic_Unit;
END$$

DELIMITER ;

CALL GetAllChefs(1);


-- DELETE PROCEDURES
DELIMITER $$

DROP PROCEDURE IF EXISTS DeleteRecipe$$
CREATE PROCEDURE DeleteRecipe(IN RecipeID INT)
BEGIN
	DELETE FROM Recipe
    WHERE ID_Recipe = RecipeID;
END$$


-- Delete procedure for National_Cusine
DROP PROCEDURE IF EXISTS DeleteNationalCusine$$
CREATE PROCEDURE DeleteNationalCusine(IN p_ID INT)
BEGIN
    DELETE FROM National_Cusine WHERE ID_National_Cusine = p_ID;
END$$

-- Delete procedure for Meal
DROP PROCEDURE IF EXISTS DeleteMeal$$
CREATE PROCEDURE DeleteMeal(IN p_ID INT)
BEGIN
    DELETE FROM Meal WHERE ID_Meal = p_ID;
END$$

-- Delete procedure for Tags
DROP PROCEDURE IF EXISTS DeleteTags$$
CREATE PROCEDURE DeleteTags(IN p_ID INT)
BEGIN
    DELETE FROM Tags WHERE ID_Tag = p_ID;
END$$

-- Delete procedure for Equipment
DROP PROCEDURE IF EXISTS DeleteEquipment$$
CREATE PROCEDURE DeleteEquipment(IN p_ID INT)
BEGIN
    DELETE FROM Equipment WHERE ID_Equipment = p_ID;
END$$

-- Delete procedure for Food_Category
DROP PROCEDURE IF EXISTS DeleteFoodCategory$$
CREATE PROCEDURE DeleteFoodCategory(IN p_Code INT)
BEGIN
    DELETE FROM Food_Category WHERE Code = p_Code;
END$$

-- Delete procedure for Thematic_Unit
DROP PROCEDURE IF EXISTS DeleteThematicUnit$$
CREATE PROCEDURE DeleteThematicUnit(IN p_ID INT)
BEGIN
    DELETE FROM Thematic_Unit WHERE ID_Thematic_Unit = p_ID;
END$$


DELIMITER ;




-- INSERT PROCEDURES
DELIMITER $$

DROP PROCEDURE IF EXISTS AddNational_Cusine$$
CREATE PROCEDURE AddNationalCusine(IN p_Name VARCHAR(255), IN p_Photo TEXT, IN p_Photo_Description VARCHAR(255))
BEGIN
    INSERT INTO National_Cusine (Name, Photo, Photo_Description)
    VALUES (p_Name, p_Photo, p_Photo_Description);
END$$

DROP PROCEDURE IF EXISTS AddMeal$$
CREATE PROCEDURE AddMeal(IN p_Name VARCHAR(255), IN p_Photo TEXT, IN p_Photo_Description VARCHAR(255))
BEGIN
    INSERT INTO Meal (Name, Photo, Photo_Description)
    VALUES (p_Name, p_Photo, p_Photo_Description);
END$$


DROP PROCEDURE IF EXISTS AddTag$$
CREATE PROCEDURE AddTag(IN p_Name VARCHAR(255), IN p_Photo TEXT, IN p_Photo_Description VARCHAR(255))
BEGIN
    INSERT INTO Tags (Name, Photo, Photo_Description)
    VALUES (p_Name, p_Photo, p_Photo_Description);
END$$


DROP PROCEDURE IF EXISTS AddEquipment$$
CREATE PROCEDURE AddEquipment(IN p_Name VARCHAR(255), IN p_Instructions TEXT,IN p_Photo TEXT, IN p_Photo_Description VARCHAR(255))
BEGIN
    INSERT INTO Equipment (Name, Instructions, Photo, Photo_Description)
    VALUES (p_Name, p_Instructions, p_Photo, p_Photo_Description);
END$$


DROP PROCEDURE IF EXISTS AddFoodCategory$$
CREATE PROCEDURE AddFoodCategory(IN p_Name VARCHAR(255), IN p_Description VARCHAR(255), IN p_Photo TEXT, IN p_Photo_Description VARCHAR(255))
BEGIN
    INSERT INTO Food_Category (Name, Description, Photo, Photo_Description)
    VALUES (p_Name, p_Description, p_Photo, p_Photo_Description);
END$$


DROP PROCEDURE IF EXISTS AddThematicUnit$$
CREATE PROCEDURE AddThematicUnit(IN p_Name VARCHAR(255), IN p_Description TEXT,IN p_Photo TEXT, IN p_Photo_Description VARCHAR(255))
BEGIN
    INSERT INTO Thematic_Unit (Name, Description, Photo, Photo_Description)
    VALUES (p_Name, p_Description, p_Photo, p_Photo_Description);
END$$

DELIMITER ;



-- UPDATE PROCEDURES
DELIMITER $$

-- Update procedure for National_Cusine
DROP PROCEDURE IF EXISTS UpdateNationalCusine$$
CREATE PROCEDURE UpdateNationalCusine(
    IN p_ID INT,
    IN p_Name VARCHAR(255),
    IN p_Photo TEXT,
    IN p_Photo_Description VARCHAR(255)
)
BEGIN
    UPDATE National_Cusine
    SET Name = p_Name,
        Photo = p_Photo,
        Photo_Description = p_Photo_Description
    WHERE ID_National_Cusine = p_ID;
END$$

-- Update procedure for Meal
DROP PROCEDURE IF EXISTS UpdateMeal$$
CREATE PROCEDURE UpdateMeal(
    IN p_ID INT,
    IN p_Name VARCHAR(255),
    IN p_Photo TEXT,
    IN p_Photo_Description VARCHAR(255)
)
BEGIN
    UPDATE Meal
    SET Name = p_Name,
        Photo = p_Photo,
        Photo_Description = p_Photo_Description
    WHERE ID_Meal = p_ID;
END$$

-- Update procedure for Tags
DROP PROCEDURE IF EXISTS UpdateTags$$
CREATE PROCEDURE UpdateTags(
    IN p_ID INT,
    IN p_Name VARCHAR(255),
    IN p_Photo TEXT,
    IN p_Photo_Description VARCHAR(255)
)
BEGIN
    UPDATE Tags
    SET Name = p_Name,
        Photo = p_Photo,
        Photo_Description = p_Photo_Description
    WHERE ID_Tag = p_ID;
END$$

-- Update procedure for Equipment
DROP PROCEDURE IF EXISTS UpdateEquipment$$
CREATE PROCEDURE UpdateEquipment(
    IN p_ID INT,
    IN p_Name VARCHAR(255),
    IN p_Instructions TEXT,
    IN p_Photo TEXT,
    IN p_Photo_Description VARCHAR(255)
)
BEGIN
    UPDATE Equipment
    SET Name = p_Name,
        Instructions = p_Instructions,
        Photo = p_Photo,
        Photo_Description = p_Photo_Description
    WHERE ID_Equipment = p_ID;
END$$

-- Update procedure for Food_Category
DROP PROCEDURE IF EXISTS UpdateFoodCategory$$
CREATE PROCEDURE UpdateFoodCategory(
    IN p_Code INT,
    IN p_Name VARCHAR(255),
    IN p_Description VARCHAR(255),
    IN p_Photo TEXT,
    IN p_Photo_Description VARCHAR(255)
)
BEGIN
    UPDATE Food_Category
    SET Name = p_Name,
        Description = p_Description,
        Photo = p_Photo,
        Photo_Description = p_Photo_Description
    WHERE Code = p_Code;
END$$

-- Update procedure for Thematic_Unit
DROP PROCEDURE IF EXISTS UpdateThematicUnit$$
CREATE PROCEDURE UpdateThematicUnit(
    IN p_ID INT,
    IN p_Name VARCHAR(255),
    IN p_Description TEXT,
    IN p_Photo TEXT,
    IN p_Photo_Description VARCHAR(255)
)
BEGIN
    UPDATE Thematic_Unit
    SET Name = p_Name,
        Description = p_Description,
        Photo = p_Photo,
        Photo_Description = p_Photo_Description
    WHERE ID_Thematic_Unit = p_ID;
END$$

DELIMITER ;