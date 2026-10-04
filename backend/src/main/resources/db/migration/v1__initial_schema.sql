-- V1__initial_schema.sql
-- Generated from v8final.dbs (ResidentMS). PostgreSQL 17.
-- Tables are ordered so every foreign key target already exists.
-- Check constraints are enforced

CREATE TABLE resident (

                          resident_id             INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
                          first_name              VARCHAR(100) NOT NULL,
                          last_name               VARCHAR(100),
                          email                   VARCHAR(255) NOT NULL,
                          phone_number            VARCHAR(10) NOT NULL,
                          password_hash           VARCHAR(255) NOT NULL,
                          profile_pic             VARCHAR(2048),
                          CONSTRAINT pk_resident PRIMARY KEY (resident_id),
                          CONSTRAINT uq_email UNIQUE (email),
                          CONSTRAINT uq_phone_number UNIQUE (phone_number),
                          CONSTRAINT ck_resident_phone_digits CHECK (phone_number ~ '^[0-9]{10}$')
    );

CREATE TABLE role (
                      role_id                 INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
                      role_name               VARCHAR(100) NOT NULL,
                      can_approve_visitors    BOOLEAN NOT NULL,
                      can_post_notices        BOOLEAN NOT NULL,
                      CONSTRAINT pk_role PRIMARY KEY (role_id),
                      CONSTRAINT uq_role UNIQUE (role_name)
);

CREATE TABLE society (
                         society_id              INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
                         society_name            VARCHAR(100) NOT NULL,
                         registration_number     VARCHAR(100) NOT NULL,
                         address                 VARCHAR(255) NOT NULL,
                         city                    VARCHAR(100) NOT NULL,
                         zip_code                INTEGER,
                         CONSTRAINT pk_society PRIMARY KEY (society_id),
                         CONSTRAINT uq_society_reg_no UNIQUE (registration_number)
);

CREATE TABLE visitor (
                         visitor_id              INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
                         visitor_name            VARCHAR(100) NOT NULL,
                         phone_number            VARCHAR(10),
                         visitor_pic             VARCHAR(2048),
                         vehicle_number          VARCHAR(50),
                         CONSTRAINT pk_visitor PRIMARY KEY (visitor_id),
                         CONSTRAINT ck_visitor_phone_digits CHECK (phone_number IS NULL OR phone_number ~ '^[0-9]{10}$')
    );

CREATE TABLE amenity (
                         amenity_id              INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
                         society_id              INTEGER NOT NULL,
                         amenity_name            VARCHAR(100) NOT NULL,
                         operational_hours       VARCHAR(50),
                         is_bookable             BOOLEAN NOT NULL,
                         CONSTRAINT pk_amenity PRIMARY KEY (amenity_id),
                         CONSTRAINT fk_amenity_society FOREIGN KEY (society_id) REFERENCES society (society_id)
);

CREATE TABLE asset (
                       asset_id                INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
                       society_id              INTEGER NOT NULL,
                       asset_name              VARCHAR(500) NOT NULL,
                       purchase_date           DATE,
                       next_service_due        DATE,
                       asset_status            VARCHAR(50) NOT NULL,
                       CONSTRAINT pk_asset PRIMARY KEY (asset_id),
                       CONSTRAINT fk_asset_society FOREIGN KEY (society_id) REFERENCES society (society_id)
);

CREATE TABLE block (
                       block_id                INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
                       society_id              INTEGER NOT NULL,
                       block_name              VARCHAR(100) NOT NULL,
                       total_floors            INTEGER,
                       CONSTRAINT pk_block PRIMARY KEY (block_id),
                       CONSTRAINT uq_block UNIQUE (society_id, block_name),
                       CONSTRAINT ck_block_total_floors_positive CHECK (total_floors IS NULL OR total_floors > 0),
                       CONSTRAINT fk_block_society FOREIGN KEY (society_id) REFERENCES society (society_id)
);

CREATE TABLE society_resident (
                                  society_resident_id     INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
                                  society_id              INTEGER NOT NULL,
                                  resident_id             INTEGER NOT NULL,
                                  role_id                 INTEGER NOT NULL,
                                  society_resident_status VARCHAR(50) NOT NULL,
                                  joined_date             DATE NOT NULL,
                                  left_date               DATE,
                                  CONSTRAINT pk_society_resident PRIMARY KEY (society_resident_id),
                                  CONSTRAINT uq_society_resident UNIQUE (society_id, resident_id),
                                  CONSTRAINT ck_society_resident_dates CHECK (left_date IS NULL OR left_date >= joined_date),
                                  CONSTRAINT fk_society_resident_society FOREIGN KEY (society_id) REFERENCES society (society_id),
                                  CONSTRAINT fk_society_resident_resident FOREIGN KEY (resident_id) REFERENCES resident (resident_id),
                                  CONSTRAINT fk_society_resident_role FOREIGN KEY (role_id) REFERENCES role (role_id)
);

CREATE TABLE staff (
                       staff_id                INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
                       society_id              INTEGER NOT NULL,
                       first_name              VARCHAR(100) NOT NULL,
                       last_name               VARCHAR(100),
                       phone_number            VARCHAR(10) NOT NULL,
                       staff_role              VARCHAR(50) NOT NULL,
                       aadhar_number           VARCHAR(50),
                       work_shift              VARCHAR(255),
                       CONSTRAINT pk_staff PRIMARY KEY (staff_id),
                       CONSTRAINT ck_staff_phone_digits CHECK (phone_number ~ '^[0-9]{10}$'),
    CONSTRAINT fk_staff_society FOREIGN KEY (society_id) REFERENCES society (society_id)
);

CREATE TABLE amenity_booking (
                                 booking_id              INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
                                 amenity_id              INTEGER NOT NULL,
                                 resident_id             INTEGER NOT NULL,
                                 booking_date            DATE NOT NULL,
                                 booking_duration        VARCHAR(10),
                                 CONSTRAINT pk_amenity_booking PRIMARY KEY (booking_id),
                                 CONSTRAINT fk_amenity_booking_amenity FOREIGN KEY (amenity_id) REFERENCES amenity (amenity_id),
                                 CONSTRAINT fk_amenity_booking_resident FOREIGN KEY (resident_id) REFERENCES resident (resident_id)
);

CREATE TABLE flat (
                      flat_id                 INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
                      flat_number             VARCHAR(50) NOT NULL,
                      square_foot             DECIMAL(10,2),
                      flat_type               VARCHAR(50),
                      current_status          VARCHAR(50) NOT NULL,
                      block_id                INTEGER NOT NULL,
                      CONSTRAINT pk_flat PRIMARY KEY (flat_id),
                      CONSTRAINT uq_flat UNIQUE (flat_number, block_id),
                      CONSTRAINT ck_flat_square_foot_positive CHECK (square_foot IS NULL OR square_foot > 0),
                      CONSTRAINT fk_flat_block FOREIGN KEY (block_id) REFERENCES block (block_id)
);

CREATE TABLE flat_resident (
                               flat_resident_id        INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
                               flat_id                 INTEGER NOT NULL,
                               resident_id             INTEGER NOT NULL,
                               occupancy_type          VARCHAR(50) NOT NULL,
                               CONSTRAINT ck_flat_resident_occupancy_type CHECK (occupancy_type IN ('owner', 'tenant')),
                               start_date              DATE NOT NULL,
                               end_date                DATE,
                               CONSTRAINT pk_flat_resident PRIMARY KEY (flat_resident_id),
                               CONSTRAINT uq_flat_resident UNIQUE (flat_id, resident_id, start_date),
                               CONSTRAINT ck_flat_resident_dates CHECK (end_date IS NULL OR end_date >= start_date),
                               CONSTRAINT fk_flat_resident_flat FOREIGN KEY (flat_id) REFERENCES flat (flat_id),
                               CONSTRAINT fk_flat_resident_resident FOREIGN KEY (resident_id) REFERENCES resident (resident_id)
);

CREATE TABLE maintenance (
                             maintenance_id          INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
                             flat_id                 INTEGER NOT NULL,
                             generation_date         DATE NOT NULL,
                             due_date                DATE NOT NULL,
                             penalty_amt             DECIMAL(10,2) NOT NULL,
                             total_due_amt           DECIMAL(10,2) NOT NULL,
                             billed_to               INTEGER NOT NULL,
                             CONSTRAINT pk_maintenance PRIMARY KEY (maintenance_id),
                             CONSTRAINT ck_maintenance_penalty_non_negative CHECK (penalty_amt >= 0),
                             CONSTRAINT ck_maintenance_total_due_non_negative CHECK (total_due_amt >= 0),
                             CONSTRAINT ck_maintenance_total_covers_penalty CHECK (total_due_amt >= penalty_amt),
                             CONSTRAINT ck_maintenance_due_after_generation CHECK (due_date >= generation_date),
                             CONSTRAINT fk_maintenance_flat FOREIGN KEY (flat_id) REFERENCES flat (flat_id),
                             CONSTRAINT fk_maintenance_resident FOREIGN KEY (billed_to) REFERENCES resident (resident_id)
);

CREATE TABLE parking_slot (
                              slot_id                 INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
                              society_id              INTEGER NOT NULL,
                              flat_id                 INTEGER,
                              vehicle_type_allowed    VARCHAR(50),
                              location_type           VARCHAR(50),
                              CONSTRAINT pk_parking_slot PRIMARY KEY (slot_id),
                              CONSTRAINT fk_parking_slot_flat FOREIGN KEY (flat_id) REFERENCES flat (flat_id),
                              CONSTRAINT fk_parking_slot_society FOREIGN KEY (society_id) REFERENCES society (society_id)
);

CREATE TABLE vehicle (
                         vehicle_id              INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
                         flat_id                 INTEGER NOT NULL,
                         registration_number     VARCHAR(100) NOT NULL,
                         vehicle_type            VARCHAR(50) NOT NULL,
                         CONSTRAINT pk_vehicle PRIMARY KEY (vehicle_id),
                         CONSTRAINT uq_vehicle_reg UNIQUE (registration_number),
                         CONSTRAINT fk_vehicle_flat FOREIGN KEY (flat_id) REFERENCES flat (flat_id)
);

CREATE TABLE visitor_log (
                             log_id                  INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
                             visitor_id              INTEGER NOT NULL,
                             flat_id                 INTEGER NOT NULL,
                             resident_id             INTEGER NOT NULL,
                             entry_time              TIMESTAMP,
                             exit_time               TIMESTAMP,
                             CONSTRAINT pk_visitor_log PRIMARY KEY (log_id),
                             CONSTRAINT ck_visitor_log_times CHECK (exit_time IS NULL OR entry_time IS NULL OR exit_time >= entry_time),
                             CONSTRAINT fk_visitor_log_visitor FOREIGN KEY (visitor_id) REFERENCES visitor (visitor_id),
                             CONSTRAINT fk_visitor_log_flat FOREIGN KEY (flat_id) REFERENCES flat (flat_id),
                             CONSTRAINT fk_visitor_log_resident FOREIGN KEY (resident_id) REFERENCES resident (resident_id)
);

CREATE TABLE payment (
                         payment_id              INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
                         maintenance_id          INTEGER NOT NULL,
                         resident_id             INTEGER NOT NULL,
                         amt_paid                DECIMAL(10,2) NOT NULL,
                         payment_date            TIMESTAMP NOT NULL,
                         payment_method          VARCHAR(50),
                         payment_status          VARCHAR(50),
                         CONSTRAINT pk_payment PRIMARY KEY (payment_id),
                         CONSTRAINT ck_payment_amt_paid_positive CHECK (amt_paid > 0),
                         CONSTRAINT fk_payment_maintenance FOREIGN KEY (maintenance_id) REFERENCES maintenance (maintenance_id),
                         CONSTRAINT fk_payment_resident FOREIGN KEY (resident_id) REFERENCES resident (resident_id)
);

CREATE TABLE tenancy (
                         tenancy_id              INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
                         flat_resident_id        INTEGER NOT NULL,
                         rent_amount             DECIMAL(10,2) NOT NULL,
                         deposit_amount          DECIMAL(10,2),
                         lease_start             DATE NOT NULL,
                         lease_end               DATE,
                         verification_status     VARCHAR(50),
                         CONSTRAINT pk_tenancy PRIMARY KEY (tenancy_id),
                         CONSTRAINT uq_tenancy_flat_resident UNIQUE (flat_resident_id),
                         CONSTRAINT ck_tenancy_rent_positive CHECK (rent_amount > 0),
                         CONSTRAINT ck_tenancy_deposit_non_negative CHECK (deposit_amount IS NULL OR deposit_amount >= 0),
                         CONSTRAINT ck_tenancy_lease_dates CHECK (lease_end IS NULL OR lease_end >= lease_start),
                         CONSTRAINT fk_tenancy_flat_resident FOREIGN KEY (flat_resident_id) REFERENCES flat_resident (flat_resident_id)
);

-- Indexes on foreign key columns (skipped where a unique constraint already starts with the column)
CREATE INDEX idx_amenity_society_id ON amenity (society_id);
CREATE INDEX idx_asset_society_id ON asset (society_id);
CREATE INDEX idx_society_resident_resident_id ON society_resident (resident_id);
CREATE INDEX idx_society_resident_role_id ON society_resident (role_id);
CREATE INDEX idx_staff_society_id ON staff (society_id);
CREATE INDEX idx_amenity_booking_amenity_id ON amenity_booking (amenity_id);
CREATE INDEX idx_amenity_booking_resident_id ON amenity_booking (resident_id);
CREATE INDEX idx_flat_block_id ON flat (block_id);
CREATE INDEX idx_flat_resident_resident_id ON flat_resident (resident_id);
CREATE INDEX idx_maintenance_flat_id ON maintenance (flat_id);
CREATE INDEX idx_maintenance_billed_to ON maintenance (billed_to);
CREATE INDEX idx_parking_slot_flat_id ON parking_slot (flat_id);
CREATE INDEX idx_parking_slot_society_id ON parking_slot (society_id);
CREATE INDEX idx_vehicle_flat_id ON vehicle (flat_id);
CREATE INDEX idx_visitor_log_visitor_id ON visitor_log (visitor_id);
CREATE INDEX idx_visitor_log_flat_id ON visitor_log (flat_id);
CREATE INDEX idx_visitor_log_resident_id ON visitor_log (resident_id);
CREATE INDEX idx_payment_maintenance_id ON payment (maintenance_id);
CREATE INDEX idx_payment_resident_id ON payment (resident_id);
