-- In Spring Boot using Spring Data, we use ~/src/main/resources/schema.sql to create the database schema.
-- We no longer have to use ~/src/main/resources/database/h2/schema.sql to create the database schema.

-- *** NOTE: We are going to use the following property:
-- "jpa.database-platform.hibernate.ddl-auto=none"
-- Otherwise adding ddl here would fail when loading data with data.sql

-- USERS Schema
CREATE TABLE app_users (
                          id INTEGER GENERATED BY DEFAULT AS IDENTITY,
                          email VARCHAR(50) NOT NULL UNIQUE,
                          password VARCHAR(100) NOT NULL,
                          first_name VARCHAR(50) NOT NULL,
                          last_name VARCHAR(50) NOT NULL,
                          PRIMARY KEY (id)
);

CREATE TABLE events (
                        id INTEGER GENERATED BY DEFAULT AS IDENTITY,
                        event_date TIMESTAMP NOT NULL,
                        summary VARCHAR(50) NOT NULL,
                        description VARCHAR(100) NOT NULL,
                        owner BIGINT NOT NULL,
                        attendee BIGINT NOT NULL,
                        PRIMARY KEY (id),
                        FOREIGN KEY(owner) REFERENCES app_users(id),
                        FOREIGN KEY(attendee) REFERENCES app_users(id)
);

CREATE TABLE roles (
                    id   INTEGER GENERATED BY DEFAULT AS IDENTITY,
                    name VARCHAR(55),
                    PRIMARY KEY (id)
);

CREATE TABLE user_role (
                        user_id INTEGER NOT NULL,
                        role_id INTEGER NOT NULL,
                        PRIMARY KEY (user_id, role_id),
                        FOREIGN KEY(role_id) REFERENCES roles(id),
                        FOREIGN KEY(user_id) REFERENCES app_users(id)
);

-- The End...