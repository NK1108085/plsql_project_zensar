-- 1. Create the Customers table
CREATE TABLE Customers (
    customer_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    phone_number VARCHAR2(15),
    email VARCHAR2(100),
    address VARCHAR2(200),
    registration_date DATE DEFAULT SYSDATE
);

-- 2. Create the Drivers table
CREATE TABLE Drivers (
    driver_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    phone_number VARCHAR2(15),
    license_number VARCHAR2(50),
    hire_date DATE DEFAULT SYSDATE,
    status VARCHAR2(20) CHECK (status IN ('Available', 'On Trip', 'Off Duty'))
);

-- 3. Create the Taxis table
CREATE TABLE Taxis (
    taxi_id NUMBER PRIMARY KEY,
    driver_id NUMBER,
    model VARCHAR2(50),
    license_plate VARCHAR2(20),
    FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id)
);

-- 4. Create the Trips tablef
CREATE TABLE Trips (
    trip_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    taxi_id NUMBER,
    start_location VARCHAR2(200),
    end_location VARCHAR2(200),
    trip_start_time TIMESTAMP DEFAULT SYSDATE,
    trip_end_time TIMESTAMP,
    trip_status VARCHAR2(20) CHECK (trip_status IN ('In Progress', 'Completed', 'Cancelled')),
    trip_fare DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (taxi_id) REFERENCES Taxis(taxi_id)
);

-- 5. Create the Payments table
CREATE TABLE Payments (
    payment_id NUMBER PRIMARY KEY,
    trip_id NUMBER,
    payment_amount DECIMAL(10, 2),
    payment_date TIMESTAMP DEFAULT SYSDATE,
    payment_status VARCHAR2(20) CHECK (payment_status IN ('Pending', 'Completed', 'Failed')),
    FOREIGN KEY (trip_id) REFERENCES Trips(trip_id)
);

-- 6. Create the Reservations table
CREATE TABLE Reservations (
    reservation_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    taxi_id NUMBER,
    reservation_time TIMESTAMP DEFAULT SYSDATE,
    pickup_location VARCHAR2(200),
    dropoff_location VARCHAR2(200),
    reservation_status VARCHAR2(20) CHECK (reservation_status IN ('Confirmed', 'Pending', 'Cancelled')),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (taxi_id) REFERENCES Taxis(taxi_id)
);







-- Create sequence for Customers
CREATE SEQUENCE customer_seq
    START WITH 1
    INCREMENT BY 1;

-- Create sequence for Drivers
CREATE SEQUENCE driver_seq
    START WITH 1
    INCREMENT BY 1;

-- Create sequence for Taxis
CREATE SEQUENCE taxi_seq
    START WITH 1
    INCREMENT BY 1;

-- Create sequence for Trips
CREATE SEQUENCE trip_seq
    START WITH 1
    INCREMENT BY 1;

-- Create sequence for Payments
CREATE SEQUENCE payment_seq
    START WITH 1
    INCREMENT BY 1;

-- Create sequence for Reservations
CREATE SEQUENCE reservation_seq
    START WITH 1
    INCREMENT BY 1;
    
    
    
-- Insert sample customer data
INSERT INTO Customers (customer_id, first_name, last_name, phone_number, email)
VALUES (customer_seq.NEXTVAL, 'John', 'Doe', '1234567890', 'john.doe@example.com');

-- Insert sample driver data
INSERT INTO Drivers (driver_id, first_name, last_name, phone_number, license_number, status)
VALUES (driver_seq.NEXTVAL, 'Alice', 'Smith', '9876543210', 'A1234567', 'Available');

-- Insert sample taxi data
INSERT INTO Taxis (taxi_id, driver_id, model, license_plate)
VALUES (taxi_seq.NEXTVAL, 1, 'Toyota Prius', 'XYZ 1234');

-- Insert a reservation
INSERT INTO Reservations (reservation_id, customer_id, taxi_id, pickup_location, dropoff_location, reservation_status)
VALUES (reservation_seq.NEXTVAL, 1, 1, '123 Main St', '456 Elm St', 'Confirmed');

-- Insert a trip
INSERT INTO Trips (trip_id, customer_id, taxi_id, start_location, end_location, trip_status, trip_fare)
VALUES (trip_seq.NEXTVAL, 1, 1, '123 Main St', '456 Elm St', 'Completed', 25.00);

-- Insert a payment for the trip
INSERT INTO Payments (payment_id, trip_id, payment_amount, payment_status)
VALUES (payment_seq.NEXTVAL, 1, 25.00, 'Completed');












