use evlyperu_storeDB;

CREATE TABLE NaturalPerson (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(150) NOT NULL,
  age INT CHECK (age >= 0),
  email VARCHAR(150) UNIQUE NOT NULL,
  cellphone VARCHAR(20) UNIQUE NOT NULL,
  typeDoc INT NOT NULL,
  numDoc VARCHAR(40) UNIQUE NOT NULL,
  birthday DATE,
  address VARCHAR(100),
  district INT,
  country INT,
  province INT,
  status BOOLEAN,
  adminrole BOOLEAN DEFAULT 0,
  FOREIGN KEY (typeDoc) REFERENCES TypeDocs(id),
  FOREIGN KEY (district) REFERENCES Districts(id),
  FOREIGN KEY (country) REFERENCES Countries(id),
  FOREIGN KEY (province) REFERENCES Provinces(id)
);

CREATE TABLE BusinessContacts (
  id INT PRIMARY KEY AUTO_INCREMENT,
  id_naturalperson INT NOT NULL,
  id_business INT NOT NULL,
  FOREIGN KEY (id_naturalperson) REFERENCES NaturalPerson(id),
  FOREIGN KEY (id_business) REFERENCES Business(id)
);

CREATE TABLE Business (
  id INT PRIMARY KEY AUTO_INCREMENT,
  socialReason VARCHAR(150) NOT NULL,
  merchName VARCHAR(150) NOT NULL,
  email VARCHAR(150) UNIQUE NOT NULL,
  cellphone VARCHAR(20) UNIQUE NOT NULL,
  RUC VARCHAR(60) UNIQUE NOT NULL,
  anniversary DATE,
  address VARCHAR(100),
  district INT,
  country INT,
  province INT,
  status BOOLEAN,
  isTax BOOLEAN NOT NULL DEFAULT 0,
  FOREIGN KEY (district) REFERENCES Districts(id),
  FOREIGN KEY (country) REFERENCES Countries(id),
  FOREIGN KEY (province) REFERENCES Provinces(id)
);

CREATE TABLE TypeDocs (
  id INT PRIMARY KEY,
  name VARCHAR(16) UNIQUE NOT NULL
);

CREATE TABLE Countries (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Provinces (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) UNIQUE NOT NULL,
  country_id INT NOT NULL,
  FOREIGN KEY (country_id) REFERENCES Countries(id)
);

CREATE TABLE Districts (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) UNIQUE NOT NULL,
  provincia_id INT NOT NULL,
  FOREIGN KEY (provincia_id) REFERENCES Provinces(id)
);

CREATE TABLE Products (
  id INT PRIMARY KEY AUTO_INCREMENT,
  product_name VARCHAR(255) NOT NULL,
  category_id INT NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (category_id) REFERENCES Product_Categories(category_id)
);

CREATE TABLE Attributes (
  attribute_id INT PRIMARY KEY AUTO_INCREMENT,
  attribute_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Attribute_Values (
  attribute_id INT NOT NULL,
  value_id INT PRIMARY KEY AUTO_INCREMENT,
  value_name VARCHAR(100) NOT NULL,
  FOREIGN KEY (attribute_id) REFERENCES Attributes(attribute_id)
);

CREATE TABLE Product_Variants (
  variant_id INT PRIMARY KEY AUTO_INCREMENT,
  product_id INT NOT NULL,
  attribute_value_id INT NOT NULL,
  stock INT NOT NULL DEFAULT 0,
  additional_price DECIMAL(10, 2) DEFAULT 0,
  sku VARCHAR(50) UNIQUE NOT NULL,
  FOREIGN KEY (product_id) REFERENCES Products(id),
  FOREIGN KEY (attribute_value_id) REFERENCES Attribute_Values(value_id)
);

CREATE TABLE Product_Categories (
  category_id INT PRIMARY KEY AUTO_INCREMENT,
  category_name VARCHAR(100) UNIQUE NOT NULL,
  description TEXT
);

CREATE TABLE Orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  status VARCHAR(50) NOT NULL DEFAULT 'Pending',
  total_amount DECIMAL(10, 2) NOT NULL,
  shipping_address VARCHAR(255) NOT NULL,
  shipping_method VARCHAR(50) NOT NULL,
  payment_method VARCHAR(50) NOT NULL
);

CREATE TABLE Order_Items (
  order_item_id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT NOT NULL,
  variant_id INT NOT NULL,
  quantity INT NOT NULL DEFAULT 1,
  unit_price DECIMAL(10, 2) NOT NULL,
  subtotal DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (variant_id) REFERENCES Product_Variants(variant_id)
);

CREATE TABLE Payment_Receipts (
  receipt_id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT NOT NULL,
  receipt_type_id INT NOT NULL,
  receipt_number VARCHAR(50) UNIQUE NOT NULL,
  issue_date DATE NOT NULL,
  total_amount DECIMAL(10, 2) NOT NULL,
  tax_amount DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (receipt_type_id) REFERENCES Receipt_Types(receipt_type_id)
);

CREATE TABLE Receipt_Types (
  receipt_type_id INT PRIMARY KEY AUTO_INCREMENT,
  receipt_type_name VARCHAR(50) UNIQUE NOT NULL,
  description TEXT
);