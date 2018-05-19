DROP VIEW coupleTempView;

CREATE VIEW coupleTempView (id, coupleUuid, eventTypeId, eventDate, memberUuid, stripeAccountStatus, shortUrl, city, state, zip, country, firstName, lastName, email, fianceFirstName, fianceLastName, fianceEmail, isDeleted, createdAt, createdBy, updatedAt, updatedBy, isPrivate, isHiddenSearchEngines, isActive, mergedCoupleId, isManualOverrided, isHiddenProducts, isHiddenProductsInWebsite, isHiddenRegistriesInWebsite) AS 
SELECT CoupleId, CoupleUUID, EventTypeId, EventDate, MemberId, StripeAccountStatus,
        ShortUrl, City, State, Zip, Country, Registrant1FirstName, 
        Registrant1LastName, Registrant1Email, Registrant2FirstName, 
        Registrant2LastName, Registrant2Email, IsDeleted, CreatedDate, 
        CreatedBy, ModifiedDate, ModifiedBy, IsPrivate, 
        IsHiddenSearchEngines, IsActive, MergedCoupleId, IsManualOverrided, 
        IsHiddenProducts, IsHiddenProductsInWebsite, IsHiddenRegistriesInWebsite
FROM CoupleTemp (nolock);
