-- Description: Populates `users` with a default `superadmin` user and also populates
--  `contacts` and `contact_relationships` with the pertinent data for that `superadmin` user.
-- ** Note ** If you run this file separately from the build process, do so with caution.

-- Set Database
use `edm`;

-- Prelims
SET @user_screenName = 'superadmin';
SET @user_firstName = 'Super';
SET @user_lastName = 'Administrator';
SET @user_email = 'change@me.com';

-- Unhashed password is `changeme` and should be changed once logged into system!
SET @user_password = 'sha256:1000:0ym63Iy7420k0qpIrX6PQecBzjyoYMor:jXveAXoytwz8iL/b0qGeNprCt1kRENFx';
SET @user_id = '';
SET @contact_id = '';

-- Default User
INSERT INTO `date_info` (createdDate) VALUES (UNIX_TIMESTAMP());

-- Insert contact for user
INSERT INTO `contacts` (email, firstName, lastName, userParams)
VALUES (@user_email, @user_firstName, @user_lastName, '');

-- Capture contact id
SET @contact_id = LAST_INSERT_ID();

-- Insert user entry
INSERT INTO `users` (screenName, password, `role`, date_info_id, status, contact_id)
    VALUES (@user_screenName, @user_password, 'cms-super-admin', LAST_INSERT_ID(), 'activated', @contact_id);

-- Keep user id
SET @user_id = LAST_INSERT_ID();

-- Insert relationship row (user -> contact)
INSERT INTO `user_contact_relationships` (screenName, email) 
    VALUES (@user_screenName, @user_email);

-- Show inserted user
-- SELECT * FROM `users` WHERE screenName = @user_screenName;
-- SELECT * FROM `contacts` WHERE email = @user_email;
-- SELECT * FROM `user_contact_relationships` WHERE email = @user_email;
