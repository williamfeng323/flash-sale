create nonClustered index IDX_Couple_MemberId on dbo.Couple
( MemberId
asc);
go
alter table dbo.RawRetailerRegistry
add  rawRegistryUuid   uniqueIdentifier not null default(newId());
go
create nonClustered index IDX_RawRetailerRegistry_rawRegistryUuid on dbo.RawRetailerRegistry
(
rawRegistryUuid  asc);

alter table dbo.CoupleRegistry
add  rawRegistryUuid   uniqueIdentifier null;
go

update A
    set A.rawRegistryUuid = B.rawRegistryUuid
    from dbo.CoupleRegistry A
      , dbo.RawRetailerRegistry B
    where A.RetailerId = B.RetailerId
        and A.RetailerRegistryCode = B.RetailerRegistryCode
        and B.rawRegistryUuid is not null;

go

alter table  dbo.disclaimedRegistry
add  rawRegistryUuid   uniqueIdentifier null;
go

update A
    set A.rawRegistryUuid = B.rawRegistryUuid
    from dbo.disclaimedRegistry A
      , dbo.RawRetailerRegistry B
    where A.retailerId = B.RetailerId
        and A.retailerRegistryCode = B.RetailerRegistryCode
        and B.rawRegistryUuid is not null;
go

create trigger tr_disclaimedRegistry_insert on dbo.disclaimedRegistry
    after insert
as
    begin
        declare @memberId uniqueIdentifier
          , @retailerId bigInt
          , @retailerRegistryCode uniqueIdentifier
          , @SourceCoupleId bigInt
          , @SourceCoupleUUID uniqueIdentifier
          , @NewCoupleId bigInt
          , @NewCoupleUUID uniqueIdentifier;
        select @memberId = Inserted.memberId
              , @retailerId = Inserted.retailerId
              , @retailerRegistryCode = Inserted.retailerRegistryCode
            from inserted;

        select @SourceCoupleId = CoupleId
              , @SourceCoupleUUID = CoupleUUID
            from dbo.Couple
            where MemberId = @memberId
                and CoupleId = (
                                 select top 1 CoupleId
                                    from dbo.CoupleRegistry
                                    where RetailerId = @retailerId
                                        and RetailerRegistryCode = @retailerRegistryCode
                               );

        insert into dbo.Couple
                (
                  EventTypeId
                , EventDate
                , City
                , State
                , Zip
                , Registrant1FirstName
                , Registrant1LastName
                , Registrant1Email
                , Registrant2FirstName
                , Registrant2LastName
                , Registrant2Email
                , IsDeleted
                , CreatedDate
                , CreatedBy
                , ModifiedDate
                , ModifiedBy
                , Country
                , IsPrivate
                , IsHiddenSearchEngines
                , IsActive
                , MergedCoupleId
                , IsManualOverrided
                , IsHiddenProducts
                , IsHiddenProductsInWebsite
                , IsHiddenRegistriesInWebsite
                , StripeAccountStatus
                , ShortUrl
                , SourceCoupleUUID
                , SourceCoupleId
                , MergedCoupleUUID
                , MatchAlg
                )
                select EventTypeId
                      , EventDate
                      , City
                      , State
                      , Zip
                      , Registrant1FirstName
                      , Registrant1LastName
                      , Registrant1Email
                      , Registrant2FirstName
                      , Registrant2LastName
                      , Registrant2Email
                      , IsDeleted
                      , CreatedDate
                      , 'tr_disclaimedRegistry_insert'
                      , ModifiedDate
                      , 'tr_disclaimedRegistry_insert'
                      , Country
                      , IsPrivate
                      , IsHiddenSearchEngines
                      , IsActive
                      , MergedCoupleId
                      , IsManualOverrided
                      , IsHiddenProducts
                      , IsHiddenProductsInWebsite
                      , IsHiddenRegistriesInWebsite
                      , StripeAccountStatus
                      , ShortUrl
                      , @SourceCoupleUUID
                      , @SourceCoupleId
                      , MergedCoupleUUID
                      , MatchAlg
                    from dbo.Couple
                    where CoupleId = @SourceCoupleId
                        and CoupleUUID = @SourceCoupleUUID;
        set @NewCoupleId = @@identity;

        select @NewCoupleUUID = CoupleUUID
            from dbo.Couple
            where CoupleId = @NewCoupleId;

        update dbo.CoupleRegistry
            set CoupleId = @NewCoupleId
              , CoupleUUID = @NewCoupleUUID
            where RetailerId = @retailerId
                and RetailerRegistryCode = @retailerRegistryCode;

    end;
go

create trigger tr_couple_MemberUuid_insert on dbo.Couple
    after insert
as
    begin
        declare @memberId uniqueIdentifier
          , @coupleId bigInt
          , @EventTypeId bigInt
          , @upflag int
          , @IsDeleted bit
          , @datacount int;


        select @upflag = case when b.MemberId is  null then 0
                              else 1
                         end
              , @IsDeleted = case when b.IsActive = 1
                                       and b.IsDeleted = 0 then 1
                                  else 0
                             end
              , @coupleId = b.CoupleId
              , @EventTypeId = b.EventTypeId
              , @memberId = b.MemberId
            from inserted b;

        if ( @upflag = 1 )
            begin
                select @datacount = count(1)
                    from dbo.CoupleUser
                    where CoupleId = @coupleId
                        and UUID = @memberId;
                if ( @datacount = 0 )
                    begin
                        insert into dbo.CoupleUser
                                (
                                  CoupleId
                                , IsDeleted
                                , CreatedDate
                                , CreatedBy
                                , ModifiedDate
                                , ModifiedBy
                                , EventTypeId
                                , UUID
                                )
                            values
                                (
                                  @coupleId
                                , @IsDeleted
                                , getDate()
                                , 'tr_couple_MemberUuid_insert'
                                , getDate()
                                , 'tr_couple_MemberUuid_insert'
                                , @EventTypeId
                                , @memberId
                                );
                    end;
                else
                    begin
                        update dbo.CoupleUser
                            set IsDeleted = @IsDeleted
                            where CoupleId = @coupleId
                                and UUID = @memberId;
                    end;
            end;
    end;
go
create trigger tr_couple_MemberUuid_update on dbo.Couple
    after update
as
    begin
        declare @memberId uniqueIdentifier
          , @coupleId bigInt
          , @EventTypeId bigInt
          , @upflag int
          , @IsDeleted bit
          , @datacount int;

        select @upflag = case when a.MemberId = b.MemberId then 0
                              else 1
                         end
              , @IsDeleted = case when b.IsActive = 1
                                       and b.IsDeleted = 0 then 1
                                  else 0
                             end
              , @coupleId = b.CoupleId
              , @EventTypeId = b.EventTypeId
              , @memberId = b.MemberId
            from deleted a
              , inserted b
            where a.CoupleId = b.CoupleId
                and b.MemberId is not null;

        if ( @upflag = 1 )
            begin
                select @datacount = count(1)
                    from dbo.CoupleUser
                    where CoupleId = @coupleId
                        and UUID = @memberId;
                if ( @datacount = 0 )
                    begin
                        insert into dbo.CoupleUser
                                (
                                  CoupleId
                                , IsDeleted
                                , CreatedDate
                                , CreatedBy
                                , ModifiedDate
                                , ModifiedBy
                                , EventTypeId
                                , UUID
                                )
                            values
                                (
                                  @coupleId
                                , @IsDeleted
                                , getDate()
                                , 'tr_couple_MemberUuid_insert'
                                , getDate()
                                , 'tr_couple_MemberUuid_insert'
                                , @EventTypeId
                                , @memberId
                                );
                    end;
                else
                    begin
                        update dbo.CoupleUser
                            set IsDeleted = @IsDeleted
                            where CoupleId = @coupleId
                                and UUID = @memberId;
                    end;
            end;

    end;


        go

create trigger dbo.tr_CoupleRegistry_insert on dbo.CoupleRegistry
    after insert
as
    begin
        declare @retailerId bigInt
          , @retailerRegistryCode uniqueIdentifier
          , @MatchAlg varchar(50);

        select @retailerId = Inserted.RetailerId
              , @retailerRegistryCode = Inserted.RetailerRegistryCode
              , @MatchAlg = Inserted.MatchAlg
            from inserted;

        update a
            set a.rawRegistryUuid = c.rawRegistryUuid
            from dbo.CoupleRegistry a
              , dbo.RawRetailerRegistry c
            where a.RetailerId = c.RetailerId
                and a.RetailerRegistryCode = c.RetailerRegistryCode
                and a.RetailerId = @retailerId
                and a.RetailerRegistryCode = @retailerRegistryCode;
        if isNull(@MatchAlg , '') = ''
            begin
                -- (7-Points / Self-Claimed / Email)
---- Email Match
                update Cr
                    set Cr.MatchAlg = 'Email'
                    from dbo.CoupleRegistry Cr
                      , dbo.Couple C ( noLock )
                      , dbo.RawRetailerRegistry rc ( noLock )
                    where Cr.CoupleId = C.CoupleId
                        and Cr.RetailerId = rc.RetailerId
                        and Cr.RetailerRegistryCode = rc.RetailerRegistryCode
                        and (
                              rc.RegistrantEmail = C.Registrant1Email
                              or rc.CoRegistrantEmail = C.Registrant1Email
                              or rc.RegistrantEmail = C.Registrant2Email
                              or rc.CoRegistrantEmail = C.Registrant2Email
                            )
                        and Cr.MatchAlg is null
                        and Cr.RetailerId = @retailerId
                        and Cr.RetailerRegistryCode = @retailerRegistryCode;

---- Name1&EventDate  Match

                update Cr
                    set Cr.MatchAlg = '7-Points'
                    from dbo.CoupleRegistry Cr
                      , dbo.Couple C ( noLock )
                      , dbo.RawRetailerRegistry rc ( noLock )
                    where Cr.CoupleId = C.CoupleId
                        and Cr.RetailerId = rc.RetailerId
                        and Cr.RetailerRegistryCode = rc.RetailerRegistryCode
                        and rc.RegistrantFirstName = C.Registrant1FirstName
                        and rc.RegistrantLastName = C.Registrant1LastName
                        and isNull(rc.CoRegistrantFirstName , '') = isNull(C.Registrant2FirstName , '')
                        and isNull(rc.CoRegistrantLastName , '') = isNull(C.Registrant2LastName , '')
                        and year(rc.EventDate) = year(C.EventDate)
                        and month(rc.EventDate) = month(C.EventDate)
                        and Cr.MatchAlg is null
                        and Cr.RetailerId = @retailerId
                        and Cr.RetailerRegistryCode = @retailerRegistryCode;

---- Name2&EventDate  Match
                update Cr
                    set Cr.MatchAlg = '7-Points'
                    from dbo.CoupleRegistry Cr
                      , dbo.Couple C ( noLock )
                      , dbo.RawRetailerRegistry rc ( noLock )
                    where Cr.CoupleId = C.CoupleId
                        and Cr.RetailerId = rc.RetailerId
                        and Cr.RetailerRegistryCode = rc.RetailerRegistryCode
                        and rc.RegistrantFirstName = C.Registrant2FirstName
                        and rc.RegistrantLastName = C.Registrant2LastName
                        and isNull(rc.CoRegistrantFirstName , '') = isNull(C.Registrant1FirstName , '')
                        and isNull(rc.CoRegistrantLastName , '') = isNull(C.Registrant1LastName , '')
                        and year(rc.EventDate) = year(C.EventDate)
                        and month(rc.EventDate) = month(C.EventDate)
                        and Cr.MatchAlg is null
                        and Cr.RetailerId = @retailerId
                        and Cr.RetailerRegistryCode = @retailerRegistryCode;

---- Other  Match
                update Cr
                    set Cr.MatchAlg = 'Self-Claimed'
                    from dbo.CoupleRegistry Cr
                    where Cr.MatchAlg is null
                        and Cr.RetailerId = @retailerId
                        and Cr.RetailerRegistryCode = @retailerRegistryCode;
            end;
    end;
go
