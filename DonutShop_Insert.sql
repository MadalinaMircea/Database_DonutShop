insert into Flavours values (1, 'Chocolate')
insert into Flavours values (2, 'Vanilla')
insert into Flavours values (3, 'Hazelnuts')

select * from Flavours

insert into Donuts values (1,'Chocolate Glaze', 10, 2.5, 1)
insert into Donuts values (2,'Chocolate Swirl', 20, 1.5, 1)
insert into Donuts values (3,'Vanilla Miracle', 17, 2, 2)
insert into Donuts values (4,'Hazelnut Dream', 5, 3, 3)

select * from Donuts

insert into Boxes values (1, 'Chocolate Box 1')
insert into Boxes values (2, 'Mix Box 1')
insert into Boxes values (3, '3 in 1')

select * from Boxes

insert into DonutsBoxes values (1, 1, 1)
insert into DonutsBoxes values (2, 1, 2)
insert into DonutsBoxes values (3, 1, 1)
insert into DonutsBoxes values (4, 1, 1)
insert into DonutsBoxes values (5, 2, 2)
insert into DonutsBoxes values (6, 2, 3)
insert into DonutsBoxes values (7, 3, 1)
insert into DonutsBoxes values (8, 3, 2)
insert into DonutsBoxes values (9, 3, 3)

select * from DonutsBoxes

insert into Clients values (1, 'Mircea Madalina', '0743083164', 'Cluj')
insert into Clients values (2, 'Mircea Ioana', '0722575001', 'Mures')
insert into Clients values (3, 'Mircea Doru', '0737800700', 'Bucuresti')

select * from Clients
