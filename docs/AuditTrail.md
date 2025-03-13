
Step 1: Create the Audit Trail Table in PostgreSQL

    CREATE TABLE audit_trail (
        id SERIAL PRIMARY KEY, -- Unique ID for each audit record
        action_type VARCHAR(10) NOT NULL, -- Type of action: INSERT, UPDATE, DELETE
        table_name VARCHAR(50) NOT NULL, -- Name of the table being modified
        record_id INT NOT NULL, -- ID of the record being modified
        before_data JSONB, -- Data before the change (NULL for INSERT)
        after_data JSONB, -- Data after the change (NULL for DELETE)
        changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp of the change
        changed_by INT -- ID of the user who made the change
    );

Step 2: Implement Triggers for Insert, Update, and Delete
To automatically populate the audit_trail table whenever data changes, you can use PostgreSQL triggers. Below is an example of how to create triggers for a hypothetical users table.

Trigger for INSERT
When a new record is inserted into the users table, the trigger will log the action in the audit_trail table.

    CREATE OR REPLACE FUNCTION log_insert()
    RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO audit_trail (action_type, table_name, record_id, after_data, changed_by)
        VALUES ('INSERT', TG_TABLE_NAME, NEW.id, row_to_json(NEW), NEW.last_modified_by);
        RETURN NEW;
    END;
   

    CREATE TRIGGER users_insert_trigger
    AFTER INSERT ON users
    FOR EACH ROW
    EXECUTE FUNCTION log_insert();

Trigger for UPDATE
When a record is updated in the users table, the trigger will log the action in the audit_trail table, including both the old and new data.

    CREATE OR REPLACE FUNCTION log_update()
    RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO audit_trail (action_type, table_name, record_id, before_data, after_data, changed_by)
        VALUES ('UPDATE', TG_TABLE_NAME, NEW.id, row_to_json(OLD), row_to_json(NEW), NEW.last_modified_by);
        RETURN NEW;
    END;
   

    CREATE TRIGGER users_update_trigger
    AFTER UPDATE ON users
    FOR EACH ROW
    EXECUTE FUNCTION log_update();

