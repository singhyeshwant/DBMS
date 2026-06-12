-- Creating a Table 'locations_info' --
CREATE TABLE locations_info (
    iso_code VARCHAR (2)   PRIMARY KEY,
    location VARCHAR (255) 
);


-- Creating a Table 'us_date' --
CREATE TABLE us_date (
    date DATE PRIMARY KEY
);


-- Creating a Table 'daily_observations_source' --
CREATE TABLE daily_observations_source (
    source_url      VARCHAR (255) NOT NULL,
    observation_iso VARCHAR (2),
    FOREIGN KEY (
        observation_iso
    )
    REFERENCES locations_info (iso_code),
    PRIMARY KEY (
        source_url
    )
);

-- Creating a Table 'locations' --
CREATE TABLE locations (
    iso_code              VARCHAR (2),
    last_observation_date DATE,
    source_name           VARCHAR,
    source_website        VARCHAR (255),
    FOREIGN KEY (
        iso_code
    )
    REFERENCES locations_info (iso_code),
    PRIMARY KEY (
        iso_code
    )
);

-- Creating a Table 'us_state_location' --
CREATE TABLE us_state_location (
    state_location VARCHAR (255) NOT NULL,
    PRIMARY KEY (
        state_location
    )
);

-- Creating a Table 'vaccinations' --
CREATE TABLE vaccinations (
    all_iso_code                        VARCHAR (2),
    vaccination_date                    DATE,
    total_vaccinations                  INT,
    people_vaccinated                   INT,
    people_fully_vaccinated             INT,
    total_boosters                      INT,
    daily_vaccinations_raw              INT,
    daily_vaccinations                  INT,
    people_vaccinated_per_hundred       FLOAT,
    people_fully_vaccinated_per_hundred FLOAT,
    total_boosters_per_hundred          FLOAT,
    daily_vaccinations_per_million      FLOAT,
    daily_people_vaccinated             INT,
    daily_people_vaccinated_per_hundred FLOAT,
    FOREIGN KEY (
        all_iso_code
    )
    REFERENCES locations_info (iso_code),
    PRIMARY KEY (
        all_iso_code,
        vaccination_date
    )
);

-- Creating a Table 'vaccinations_by_manufacturer' --
CREATE TABLE vaccinations_by_manufacturer (
    iso_code           VARCHAR (2),
    date               DATE,
    vaccine            VARCHAR (255),
    total_vaccinations INT,
    FOREIGN KEY (
        iso_code
    )
    REFERENCES locations_info (iso_code),
    PRIMARY KEY (
        iso_code,
        date,
        vaccine
    )
);

-- Creating a Table 'vaccinations_by_age_group' --
CREATE TABLE vaccinations_by_age_group (
    iso_code                            VARCHAR (2),
    date                                DATE,
    age_group                           VARCHAR (255),
    people_vaccinated_per_hundred       FLOAT,
    people_fully_vaccinated_per_hundred FLOAT,
    people_with_booster_per_hundred     FLOAT,
    FOREIGN KEY (
        iso_code
    )
    REFERENCES locations_info (iso_code),
    PRIMARY KEY (
        iso_code,
        date,
        age_group
    )
);

-- Creating a Table 'us_state_vaccinations' --
CREATE TABLE us_state_vaccinations (
    date                                DATE,
    state_location                      VARCHAR (255),
    total_vaccinations                  INT,
    total_distributed                   INT,
    people_vaccinated                   INT,
    people_fully_vaccinated_per_hundred FLOAT,
    total_vaccinations_per_hundred      FLOAT,
    people_fully_vaccinated             INT,
    people_vaccinated_per_hundred       FLOAT,
    distributed_per_hundred             FLOAT,
    daily_vaccinations_raw              INT,
    daily_vaccinations                  INT,
    daily_vaccinations_per_million      FLOAT,
    share_doses_used                    FLOAT,
    total_boosters                      INT,
    total_boosters_per_hundred          FLOAT,
    FOREIGN KEY (
        date
    )
    REFERENCES us_date (date),
    FOREIGN KEY (
        state_location
    )
    REFERENCES us_state_location (state_location),
    PRIMARY KEY (
        date,
        state_location
    )
);

-- Creating a Table 'daily_observations' --
CREATE TABLE daily_observations (
    source_url              VARCHAR (255),
    date                    DATE,
    total_vaccinations      INT,
    people_vaccinated       INT,
    people_fully_vaccinated INT,
    total_boosters          INT,
    FOREIGN KEY (
        source_url
    )
    REFERENCES daily_observations_source (source_url),
    PRIMARY KEY (
        source_url,
        date
    )
);

-- Creating a Table 'vaccine_type' --
CREATE TABLE vaccine_type (
    vac_iso_code VARCHAR (2)   NOT NULL,
    vaccines     VARCHAR (255),
    FOREIGN KEY (
        vac_iso_code
    )
    REFERENCES locations (iso_code),
    PRIMARY KEY (
        vac_iso_code,
        vaccines
    )
);

-- Creating a Table 'daily_vac' --
CREATE TABLE daily_vac (
    source_url VARCHAR (255),
    date       DATE,
    vaccine    VARCHAR (255),
    FOREIGN KEY (
        source_url,
        date
    )
    REFERENCES daily_observations (source_url,
    date),
    PRIMARY KEY (
        source_url,
        date,
        vaccine
    )
);
