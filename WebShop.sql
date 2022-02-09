CREATE DATABASE WebShop
go

use WebShop
go

create table AppUser
(
	IDAppUser int primary key identity,
	Username nvarchar(100) not null,
	UserPassword nvarchar(100) not null,
	UserAddress nvarchar(100) not null,
	IsAdmin bit not null
)
go

insert into AppUser values ('admin','admin','',1)
go


create table Category
(
	IDCategory int primary key identity,
	Title nvarchar(100) not null
)
go

insert into Category values('T-Shirts'),('Sweatshirts'),('Jackets'),('Pants')
go

create table Item
(
	IDItem int primary key identity,
	ItemName nvarchar(100) not null,
	ItemDescription nvarchar(100),
	Price decimal not null,
	AvailableAmount int not null,
	ItemImage varbinary(max),
	CategoryID int not null,

	foreign key (CategoryID) references Category (IDCategory)
)
go

/*(select * from openrowset(bulk N'C:\Users\Mladen\Desktop\Java Web projekt\WebShop\web\Assets\images\plain-white-t-shirt.jpg',single_blob)as shirt1),
  (select * from openrowset(bulk N'C:\Users\Mladen\Desktop\Java Web projekt\WebShop\web\Assets\images\plain-black-t-shirt.jpg',single_blob)as shirt2),
  (select * from openrowset(bulk N'C:\Users\Mladen\Desktop\Java Web projekt\WebShop\web\Assets\images\mens-plain-sweat-t-shirt.jpg',single_blob)as sshirt1),
  (select * from openrowset(bulk N'C:\Users\Mladen\Desktop\Java Web projekt\WebShop\web\Assets\images\green-sweatshirt-500x500.jpg',single_blob)as sshirt2),
  (select * from openrowset(bulk N'C:\Users\Mladen\Desktop\Java Web projekt\WebShop\web\Assets\images\blue-jacket.jpg',single_blob)as jacket1),
  (select * from openrowset(bulk N'C:\Users\Mladen\Desktop\Java Web projekt\WebShop\web\Assets\images\jeans.jpg',single_blob)as jeans)
*/
--set identity_insert Item on

insert into Item 
	values 
		('Plain white t-shirt', null, 14.99,5,null,1),
		('Plain black t-shirt', null, 14.99,7,null,1),
		('Blue sweatshirt', null, 29.99,12,null,2),
		('Green sweatshirt', null, 29.99,10,null,2),
		('Blue jacket', null, 34.99,8,null,3),
		('Jeans', null, 24.99,3,null,4)
go

create table Bill
(
	IDBill int primary key identity,
	AppUserID int not null,
	DateOfPurchase datetime not null,
	PaymentMethod nvarchar(max),
	Total decimal not null

	foreign key (AppUserID) references AppUser (IDAppUser)
)
go

create table Item_Bill
(
	ItemID int not null,
	BillID int not null,

	foreign key (ItemID) references Item(IDItem),
	foreign key (BillID) references Bill(IDBill)
)
go


create table LoginHistory
(
	IDLoginHistory int primary key identity,
	AppUserID int not null,
	LoginTime datetime not null,
	UserAddress nvarchar(max) not null,--IP ADDRESS	

	foreign key (AppUserID) references AppUser (IDAppUser)
)
go


create table PurchaseHistory
(
	IDPurchaseHistory int primary key identity,
	AppUserID int,
	ItemID int,
	LoginHistoryID int 

	foreign key (AppUserID) references AppUser (IDAppUser),
	foreign key (ItemID) references Item(IDItem),
	foreign key (LoginHistoryID) references LoginHistory(IDLoginHistory)
)
go


--AppUser procedures
create proc createAppUser
	@IDAppUser int output,
	@Username nvarchar(100),
	@UserPassword nvarchar(100),
	@UserAddress nvarchar(100),
	@IsAdmin bit
as
begin
	insert into AppUser values (@Username, @UserPassword,@UserAddress, @IsAdmin)
	set @IDAppUser = SCOPE_IDENTITY()
end
go

create proc selectAppUser
	@IDAppUser int
as
begin
	select * from AppUser
	where IDAppUser=@IDAppUser
end
go

create proc selectAppUsers
as
begin
	select * from AppUser
end
go

create proc updateAppUser
	@IDAppUser int,
	@Username nvarchar(100),
	@UserPassword nvarchar(100),
	@UserAddress nvarchar(100),
	@IsAdmin bit
as
begin
	update AppUser set Username=@Username, UserPassword=@UserPassword, UserAddress=@UserAddress, IsAdmin=@IsAdmin
	where IDAppUser=@IDAppUser
end
go

create proc authenticateAppUser
	@Username nvarchar(100),
	@UserPassword nvarchar(100)
as
begin
	select * from AppUser where Username=@Username and UserPassword=@UserPassword
end
go

create proc getUsersById
	@IDUser int
as
begin
	select * from AppUser
	where IDAppUser = @IDUser
end
go

create proc getAllBillsOfUser
	@AppUserID int
as
begin
	select b.*,ib.ItemID from Bill as b
	inner join Item_Bill as ib
	on b.IDBill=ib.BillID
	where b.AppUserID = @AppUserID
end
go

create proc getUserShoppingHistory
	@IDUser int
as
begin
	select distinct b.IDBill,b.DateOfPurchase,b.PaymentMethod,b.Total,au.IDAppUser,ib.ItemID from Bill as b
	inner join AppUser as au
	on au.IDAppUser = b.AppUserID
	inner join Item_Bill as ib
	on b.IDBill=ib.BillID
	where b.AppUserID = @IDUser
end
go

create proc deleteAppUser
	@IDAppUser int
as
begin
	delete from AppUser
	where IDAppUser=@IDAppUser
end
go

--Category procedures
create proc createCategory
	@IDCategory int output,
	@Title nvarchar(100)
as
begin
	insert into Category values (@Title)
	set @IDCategory = SCOPE_IDENTITY()
end
go

create proc selectCategory
	@IDCategory int
as
begin
	select * from Category
	where IDCategory = @IDCategory
end
go

create proc selectCategories
as
begin
	select * from Category
end
go

create proc updateCategory
	@IDCategory int output,
	@Title nvarchar(100)
as
begin
	update Category set Title=@Title
	where IDCategory=@IDCategory
end
go

create proc getCategoriesById
	@IDCategory int
as
begin
	select * from Category
	where IDCategory=@IDCategory
end
go

create proc deleteCategory
	@IDCategory int
as
begin
	delete from Item
	where CategoryID = @IDCategory
	delete from Category
	where IDCategory = @IDCategory
end
go

--Item procedures
create proc createItem
	@IDItem int output,
	@ItemName nvarchar(100),
	@ItemDescription nvarchar(max),
	@Price decimal,
	@AvailableAmount int,
	@ItemImage varbinary(max),
	@CategoryID int
as
begin
	insert into Item values (@ItemName, @ItemDescription, @Price, @AvailableAmount, @ItemImage, @CategoryID)
	set @IDItem = SCOPE_IDENTITY()
end
go

create proc selectItem
	@IDItem int
as
begin
	select * from Item
	where IDItem=@IDItem
end
go

create proc selectItems
as
begin
	select * from Item
end
go

create proc updateItem
	@IDItem int output,
	@ItemName nvarchar(100),
	@ItemDescription nvarchar(max),
	@Price decimal,
	@AvailableAmount int,
	@ItemImage varbinary(max),
	@CategoryID int
as
begin
	update Item set ItemName=@ItemName, ItemDescription=@ItemDescription, Price=@Price, AvailableAmount=@AvailableAmount, ItemImage=@ItemImage, CategoryID=@CategoryID
	where IDItem=@IDItem
end
go

create proc getItemByCategory
@IDCategory int
as
begin
	select *  from Item as i
	where i.CategoryID=@IDCategory
end
go

create proc deleteItem
	@IDItem int
as
begin
	delete from Item
	where IDItem=@IDItem
end
go

--Bill procedures
create proc createBill
	@IDBill int output,
	@AppUserID int,
	@DateOfPurchase datetime,
	@PaymentMethod nvarchar(100),
	@Total decimal
as
begin
	insert into Bill values (@AppUserID, @DateOfPurchase, @PaymentMethod, @Total)
	set @IDBill = SCOPE_IDENTITY()
end
go

create proc selectBills
as
begin
	select * from Bill
end
go

--Item_Bill procedures
create proc bindItemsWithBill
	@ItemID int,
	@BillID int
as
begin
	insert into Item_Bill values (@ItemID,@BillID)
end
go

create proc getAllBoughtItems
as
begin
	select ItemID from Item_Bill
end
go
--drop proc getCompleteShoppingHistory
create proc getCompleteShoppingHistory
as
begin
	select b.*,ib.ItemID from Bill as b
	inner join Item_Bill as ib
	on b.IDBill=ib.BillID
end
go

create proc getAllBillItems
	@IDBill int
as
begin
	select i.* from Item_Bill as ib
	inner join Item as i
	on ib.ItemID=i.IDItem
	where ib.BillID = @IDBill
end
go

--LoginHistory procedures
create proc createLoginHistory
	@IDLoginHistory int output,
	@AppUserID int,
	@LoginTime datetime,
	@UserAddress nvarchar(max)
as
begin
	insert into LoginHistory values (@AppUserID, @LoginTime, @UserAddress)
	set @IDLoginHistory = SCOPE_IDENTITY()
end
go

create proc selectLoginHistory
	@IDLoginHistory int
as
begin
	select * from LoginHistory 
	where IDLoginHistory=@IDLoginHistory
end
go

create proc selectLoginHistories
as
begin
	select * from LoginHistory 
end
go
