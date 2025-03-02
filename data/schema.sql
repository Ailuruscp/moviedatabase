-- Create the base table for motion pictures.
CREATE TABLE MotionPicture (
  id INT AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  rating FLOAT NOT NULL,
  production VARCHAR(255),
  budget INT NOT NULL,
  PRIMARY KEY (id),
  CHECK (rating >= 0 AND rating <= 10),
  CHECK (budget > 0)
);

-- Create the User table.
-- Note: "User" is a reserved word in MySQL so we enclose it in backticks.
CREATE TABLE Users (
  email VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  age INT,
  PRIMARY KEY (email)
);

-- Create the People table.
CREATE TABLE People (
  id INT AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  nationality VARCHAR(100),
  dob DATE,
  gender VARCHAR(50),
  PRIMARY KEY (id)
);

-- Create the Movie table (a subtype of MotionPicture).
CREATE TABLE Movie (
  mpid INT NOT NULL,
  boxoffice_collection FLOAT NOT NULL,
  PRIMARY KEY (mpid),
  CHECK (boxoffice_collection >= 0),
  FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE
);

-- Create the Series table (another subtype of MotionPicture).
CREATE TABLE Series (
  mpid INT NOT NULL,
  season_count INT NOT NULL,
  PRIMARY KEY (mpid),
  CHECK (season_count >= 1),
  FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE
);

-- Create the Likes table.
CREATE TABLE Likes (
  uemail VARCHAR(255) NOT NULL,
  mpid INT NOT NULL,
  PRIMARY KEY (uemail, mpid),
  FOREIGN KEY (uemail) REFERENCES Users(email) ON DELETE CASCADE,
  FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE
);

-- Create the Role table.
CREATE TABLE Role (
  mpid INT NOT NULL,
  pid INT NOT NULL,
  role_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (mpid, pid, role_name),
  FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE,
  FOREIGN KEY (pid) REFERENCES People(id) ON DELETE CASCADE
);

-- Create the Award table.
CREATE TABLE Award (
  mpid INT NOT NULL,
  pid INT NOT NULL,
  award_name VARCHAR(255) NOT NULL,
  award_year INT NOT NULL,
  PRIMARY KEY (mpid, pid, award_name, award_year),
  FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE,
  FOREIGN KEY (pid) REFERENCES People(id) ON DELETE CASCADE
);

-- Create the Genre table.
CREATE TABLE Genre (
  mpid INT NOT NULL,
  genre_name VARCHAR(100) NOT NULL,
  PRIMARY KEY (mpid, genre_name),
  FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE
);

-- Create the Location table.
CREATE TABLE Location (
  mpid INT NOT NULL,
  zip VARCHAR(20) NOT NULL,
  city VARCHAR(255),
  country VARCHAR(255),
  PRIMARY KEY (mpid, zip),
  FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE
);