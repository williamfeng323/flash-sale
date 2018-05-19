import * as moment from 'moment';
import * as uuidv1 from 'uuid/v1';
import { couple } from './couple';
import { basicSourceData, rawRegistrySourceData, rawRetailerRegistry, requestSource } from './source-data';

const operator = {
  name: 'Neo of The Matrix',
};

const cases: any = {
  rawRegistrySourceData: {
    requestSource: requestSource.rawRegistry as 'raw-member' | 'raw-registry' | 'wedding-api' | 'tb-due-date',
    serviceUniqueId: basicSourceData.serviceUniqueId,
    timestamp: basicSourceData.timestamp,
    rawData: rawRegistrySourceData,
  },
  rawRetailerRegistry: {
    valid: rawRetailerRegistry,
    simplify: {
      sample1: {
        retailerRegistryCode: 'fakeRegistry1',
        retailerId: 99999,
        eventDate: rawRetailerRegistry.eventDate,
      },
      sample2: {
        retailerRegistryCode: 'fakeRegistry2',
        retailerId: 99999,
        eventDate: rawRetailerRegistry.eventDate,
      },
      sample3: {
        retailerRegistryCode: 'fakeRegistry3',
        retailerId: 99999,
        eventDate: rawRetailerRegistry.eventDate,
      },
    },
  },
  couple: {
    valid: {
      id: couple.id,
      createdAt: rawRetailerRegistry.createdAt,
      eventDate: rawRetailerRegistry.eventDate,
      coupleUuid: couple.coupleUuid,
      eventTypeId: rawRetailerRegistry.eventTypeId as 1 | 2,
      city: rawRetailerRegistry.city,
      state: rawRetailerRegistry.state,
      zip: rawRetailerRegistry.zip,
      country: rawRetailerRegistry.country,
      firstName: rawRetailerRegistry.firstName,
      lastName: rawRetailerRegistry.lastName,
      email: rawRetailerRegistry.email,
      fianceFirstName: rawRetailerRegistry.fianceFirstName,
      fianceLastName: rawRetailerRegistry.fianceFirstName,
      fianceEmail: rawRetailerRegistry.fianceEmail,
      isDeleted: false,
      createdBy: operator.name,
      isPrivate: false,
      isHiddenSearchEngines: false,
      isActive: true,
      mergedCoupleId: ['123'],
      isManualOverrided: true,
      isHiddenProducts: false,
      isHiddenProductsInWebsite: false,
      isHiddenRegistriesInWebsite: false,
    },
  },
  wws: {
    valid: {
      createdAt: rawRetailerRegistry.createdAt,
      coupleId: couple.id,
      wwsUuid: uuidv1(),
      affiliateId: 995,
      affiliateWebsiteCode: 'SamsonTest',
      websiteUrl: 'www.google.com',
      isDeleted: false,
      isHiddenWebsite: false,
      createdBy: operator.name,
    },
  },
  coupleRegistry: {
    valid: {
      createdAt: moment().toDate(),
      registryUuid: uuidv1(),
      registryType: rawRetailerRegistry.eventTypeId,
      coupleId: couple.id,
      retailerId: rawRetailerRegistry.retailerId,
      retailerRegistryCode: rawRetailerRegistry.retailerRegistryCode,
      altRetailerRegistryCode: rawRetailerRegistry.altRetailerRegistryCode,
      hiddenCoupleSearch: false,
      hiddenWws: false,
      isDeleted: false,
      createdBy: operator.name,
    },
    simplify: {
      sample1: {
        retailerRegistryCode: 'fakeRegistry1',
        retailerId: 99999,
        matchAlg: 'Email',
        registryType: 1,
      },
      sample2: {
        retailerRegistryCode: 'fakeRegistry2',
        retailerId: 99999,
        matchAlg: '7-Points',
        registryType: 1,
      },
      sample3: {
        retailerRegistryCode: 'fakeRegistry3',
        retailerId: 99999,
        matchAlg: 'Self-Claimed',
        registryType: 1,
      },
    },
  },
};

export { cases };
