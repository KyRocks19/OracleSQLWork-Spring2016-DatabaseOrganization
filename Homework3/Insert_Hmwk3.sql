/*Kevin Brewton, Database Organization Spring 2016*/
INSERT INTO Person VALUES (103, 'Rick', 'Man', 'rm@gmail.org', 'TRUE');
INSERT INTO Person VALUES (102, 'Morty', 'Man', 'mg@gmail.org', 'FALSE');

INSERT INTO GGroup VALUES (1, 'Friendship is Magic', 'Interest', 'This group exists to bring the magic of friendship to the masses', 'Spring', '01-JAN-2016');

INSERT INTO DiscussionForum VALUES (10, 1, '01-JAN-2016', 'Friendship Reports');

INSERT INTO Topic VALUES (100, 10, 'Honesty', 'Discussions about how to develop honesty in yourself.');
INSERT INTO Topic VALUES (101, 10, 'Kindness', 'Discussions about how to develop kindness in yourself.');
INSERT INTO Topic VALUES (102, 10, 'Generosity', 'Discussions about how to develop generosity in yourself.');
INSERT INTO Topic VALUES (103, 10, 'Laughter', 'Discussions about how to develop laughter in yourself.');
INSERT INTO Topic VALUES (104, 10, 'Loyalty', 'Discussions about how to develop loyalty in yourself.');


INSERT INTO Post VALUES (1000, 100, 'Mang@gmail.org', '01-JAN-2016', 103, '0');
INSERT INTO Post VALUES (1001, 100, 'Manmg@gmail.org', '01-JAN-2016', 103, '0');
INSERT INTO Post VALUES (1002, 100, 'Mangmail.org', '01-JAN-2016', 103, '0');
INSERT INTO Post VALUES (1003, 101, 'Manil.org', '01-JAN-2016', 103, '0');
INSERT INTO Post VALUES (1004, 101, 'Manorg', '01-JAN-2016', 103, '0');
INSERT INTO Post VALUES (1005, 104, 'Man.org', '01-JAN-2016', 103, '0');
INSERT INTO Post VALUES (1006, 104, 'Manrg', '01-JAN-2016', 103, '0');
INSERT INTO Post VALUES (1007, 103, 'Manmg@gmail.org', '01-JAN-2016', 103, '0');
INSERT INTO Post VALUES (1008, 102, 'Manmail.org', '01-JAN-2016', 103, '0');
