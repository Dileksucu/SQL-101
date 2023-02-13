select ProductID as Id , ProductName as Name , CategoryID as ctId from Products
where CategoryID=1

-- as yapısı kolonlara farklı isimler vermek için kullanılır 

select p.ProductID,p.UnitPrice,p.UnitPrice * P.UnitsInStock AS TOTAL from Products p
where UnitPrice>=25 

-- YUKARIDAKİ İKİ KULLANIM ŞEKLİDE AYNIDIR ASLINDA .

select p.ProductName,p.UnitsInStock * p.UnitPrice as Total from Products p
-- p.UnitsInStock * p.UnitPrice = burada çarpma yaptık (dört işlem yapılabilir)
-- unitprice =  birim fiyatı ,unitstock = stok adeti


select p.ProductName +' - '+ p.QuantityPerUnit from Products p
-- metinsel ifadeyi topladı yani yan yana getirdi .

-- select ifadesinde sadece tabloyla çalışmıyorsun metinsel ifadeyle de çalışırsın 

--------------------------------------------------------------------------------- AND-OR-NOT

SELECT * from Products where UnitsInStock=0 AND UnitsOnOrder>0
-- bu sorgu da ürün stockta yok ama istek sayısı fazla bu ürün acilen 
--şirket tarafından şipariş edilmeli denilebilir (Gorgonzola Telino şirketi)

select * from [Order Details] o where o.Quantity=10 or o.ProductID=5
-- or : iki koşuldan 1 nin olmuş olması yeterli 

select * from Products where not ProductName='Chai' and UnitsInStock=0
-- Chai'nin dışında olanları getir  ve stok adeti 0 olan   

---------------------------------------------------------------------------------- ORDER BY
-- ORDER BY VERİLEN KOLONA GÖRE SIRALAMA YAPAR 
select * from Products order by ProductName -- alfabetik sıralar 
select * from Products order by UnitsInStock -- nümerik sıralar 
-- (azalandan artana "default hali asc" şekilde sıralar) 

select * from Products order by ProductName desc -- Z'DEN A'YA sıralanır
-- desc : pahalıdan ucuza yani artandan azalana sıralar 
-- asc: azalandan artana sıralar 

 -- order by de yazılan sıra önemlidir 
 select * from Products order by UnitPrice ,ProductName -- burada önce fiyata göre daha sonra eşit olan varsa isme göre sıralar
 select * from Products order by ProductName asc , UnitPrice desc -- name aynı olanları fiyatına göre sıralar
 
 
 ------------------------------------------------------------------------------------

 -- like : kelime anlamı "benzer" demek 
 Select * from Products where ProductName like 'Ch%'
 -- aslında like şu anlama geliyor ; productname ch ile başlıyor demek aslında 
 -- ch'dan sonra kullanılan "%" ise ch'dan sonra kelimenin devamı vardır demek .

 select * from Products where ProductName like '%ra'
 -- burada ise : başı önemli değil ama sonu "...ra" ile bitiyor demek

 Select * from Products where ProductName like '%ch%'
 -- başı ve sonu belli olmayan  ama için dde ch geçen bütün sorguları çekeriz 

 -- between : arasında demektir 
 select * from Products where UnitPrice between 10 and 50
 --  fiyatı, iki koşulun arasında olanı getir demektir aslında 
 -- burada 10 ile 50 dahildir (iki sınır da dahildir )


 -- in :belli değerlere göre filtreleme yapmak için kullanılır 
select * from Products where CategoryID in (1,2)
 -- categoryıd'si 1 ve 2 olanlar gelir 
select * from Products p where p.ProductName  in ('Chai','Ikura')

---------------------------------------------------------------------------------------------

-- HAZIR FONKSİYONLARIN KULLANIMI

-- COUNT (*):satır sayısını verir .
 select  count(*) as [product count] from Products --77 adet ürün varmış 

 select count(ProductName) as [product rows]  from Products  -- sonuç yukarıdaki kayıtla aynı 


 select count(*) [customers rows] from Customers
 
 select count (Region) as [customer region rows] from Customers -- 31 satır varmış (count ile hesapladık)
 -- bu kolonda veriler null ve başka değerler alabiliyor (Region kolonu)

-- select Region , CustomerID from Customers where NOT Region = 'NULL' 
--Region kolonunda null olmayanları getirdik toplam 31 veri  satır geldi

-- !!!NOT : DEMEK OLUYOR Kİ ; COUNT() NULL DEĞERLERLERİNİ ALMAZ (NULL : KAYIT YOK DEMEK)
-- ONDAN NULL OLAN VERİLERİ SAYMAZ  !!!!
 
 -- Not: count() fonk. her zaman tek değer döndürür 
 ----------------------- devamı 


select MIN(UnitPrice) as price from Products
--istenen kolondaki en düşük değeri döndürür (en düşük fiyatı)
-- ve her zaman tek değer döndürür


select MAX(UnitPrice) from Products
-- istenen kolondaki en yüksek değeri döndürür
-- ve her zaman tek değer döndürür

select AVG(UnitPrice) from  Products
--avg : ortalamadır 
--istenen kolonun ortalamasını alır 

------------------------------------------------------------------------ SUM()
select SUM(UnitPrice) from Products 
-- sum : toplamadır 
--istenen kolonun bütün verilerini toplar 

select Sum (UnitPrice*Quantity) as Winnings from [Order Details] -- sistemde toplam kaç para var ?
--" birim fiyatı(unitprice) ve miktarını(quantity) çarp ve bu çapımları topla" demek bu sorgu
-----------------------------------------------------------------------

select RAND()
--RANDOM : RASGELE SAYI ÜRETMEYE YARAR


---------------------------------------------------------------------------------------------------------
-- STRİNG FONKSİYONLARLARLA ÇALIŞMA 
--(bu fonksiyonlar farklı vt'da (mesela oracle) kullanımı farklı olabilir , googledan bakarak sorguyu çekmek grekir)

-- LEFT(): SOLDAN
select LEFT(ProductName,5) from Products 
-- ProductName kolonundaki her isminin soldan ilk 5 karakteri çeken sorgu

select LEFT('engin demioğ',8) from Products --expression : metin , return :değer 
-- yazdığımız ismin(expression) soldan karakterlerini alır 
-- "engin de" sonucu döndürür bu sorgu
----------------------------
-- RİGHT():SAĞDAN
select RIGHT(ProductName,5) from Products
--productname kolonunundaki her ismin sağdan ilk 5 harfini çeken sorgu

-------------------------
-- LEN():UZUNLUK
SELECT ProductName,len(ProductName) from Products
-- productname kolonundaki her ismin karakter sayısını verir
-- aradaki boşlukları da  alır 

-------------------------
--LOWER():Küçük harfe çevirmeyi sağlar 
select lower(ProductName) from Products  -- low : düşük , aşağ demek 
select LOWER('dİlEk SuCu') from Categories

------------------------------
--UPPER():Büyük harfe çevirmeye yarar
SELECT upper(CategoryName) from Categories
select upper('mehmet sucu') from Products
------------------------------------------------------------------------------------------
-- TRİM(): Metnin başındaki ve sonundaki boşlukları atmaya yarar (trim --> boşluk )
select Trim('    DİLEK SUCU     ') from Products

Select Trim(ProductName)from Products where Trim(ProductName) = 'Chai ' 
-- chai'nin başında boşluk oldğ için veri gelmeyecek (tabloda o verinin başın da boşluk yok çünkü)
-- bur durum da TRIm fonk çalıştırılabilir (tekrar araştır )


--LTRİM() : soldaki boşluğu atmaya yarar
select Ltrim('     marry jane') from Products

--Rtrim():sağdaki boşlukları atmaya yarar
select RTRIM('david junior        ') from Products


--Reverse(): metni tersten yazar 
select REVERSE(ProductName) from Products
select REVERSE('dilek sucu') from Products

------------------------------------------------------------------
-- CHARINDEX(): BİR METNİN İÇERİNSE, BAŞKA METİN GEÇİYOR MU DİYE KULLANILIR (3 PARAMETRE ALIR )

SELECT CHARINDEX('N','ENGİN DEMİROĞ',1) AS CHARINDEX

-- 1.PARAMETRE --> hangi karakter aranacak, 2.PARAMETRE--> aranacak metin , 3.PARAMETRE--> metnin kaçıncı karakterinden başlayacak 
--2. karakterinde 'N' bulunur diye sonuç döner , ilk bulduğunu döndürür 

select ProductName from Products where CHARINDEX(' ',ProductName,1)>0
-- boşluk 0 dan büyükse var demektir ondan ">0" yaptık çünkü bu sorgu bir şonuç döndürecek 
--arasıda boşluk olanları döndürecek 

select ProductName from Products where CHARINDEX('anton',ProductName,1)>0

----------------------------------------------------------------------------------------

--REPLACE() : BİR KARAKTER TOPLULUĞUNU BAŞKA BİR KARAKTER TOPLULUĞUYLA DEĞİŞTİRİR 

SELECT REPLACE('dilek sucu',' ' ,'_') 
-- 1.boşluk(değiştirilecek metin ; 2.boşluk(aranan alan ;3.boşluk (yerine koyulacak karakter )) 

select Replace(ProductName,' ','_') from Products

----------------------------------------------------------------------------

--SUBSTRİNG : METNİ PARÇALAMAYA YARAR

SELECT SUBSTRING('dilek sucu',1,5)
-- 1.karakterden itibaren 5 karakteri al (parçala) 
-- biz bu  metodu LEFT gibi çalıştırdık mesela

select SUBSTRING('dilek sucu',2,5)
select SUBSTRING(ProductName,2,5)from Products

-------------------------------------------------------------------------
--ASCII :Karakterlerin ascii  tablosundaki değerlerini verir 
--CHAR : CHAR DA İÇİNE YAZILAN DEĞERİN KARAKTER KARŞILIĞINI VERİR
SELECT ASCII('a')
select ASCII('A')
select ASCII('3')

SELECT CHAR(65)







