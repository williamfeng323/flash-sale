import { RegModel } from '@registry/data-model';
import { RegTypes } from '@registry/registry-core-lib';
import * as moment from 'moment';
import * as uuid from 'uuid/v1';

const basicSourceData = {
  serviceUniqueId: 'testRegistryServices',
  timestamp: moment().toDate(),
};

const rawRegistrySourceData = {
  retailerId: 14020,
  retailerRegistryCode: '103O6KWMV59WY',
  eventDate: moment().toDate(),
};

const requestSource = {
  rawMember: 'raw-member',
  rawRegistry: 'raw-registry',
  weddingApi: 'wedding-api',
  tbDueDate: 'tb-due-date',
} ;

const rawRetailerRegistry: RegModel.IRawRetailerRegistry = {
  retailerId: rawRegistrySourceData.retailerId,
  retailerRegistryCode: rawRegistrySourceData.retailerRegistryCode,
  eventTypeId: 1,
  eventDate: moment('2012-07-21', 'yyyy-mm-dd').toDate(),
  firstName: 'Julie',
  lastName: 'Biddle',
  email: 'jabiddle@gmail.com',
  fianceFirstName: 'Matt',
  fianceLastName: 'Sheridan',
  fianceEmail: null,
  city: 'Princeton, IN',
  state: 'IN',
  country: 'US',
  referralStatusCode: 'N',
  eventDescription: 'Wedding',
  actualCreatedAt: moment('2013-03-19', 'yyyy-mm-dd').toDate(),
  actualModifiedAt: moment('2013-04-18', 'yyyy-mm-dd').toDate(),
  registryClickId: null,
  altRetailerRegistryCode: null,
};

export const getMemberCoreRequest = (testMemberId?: string): RegTypes.CoreService.ICoreRequest => {
  const memberId = testMemberId ? testMemberId : uuid();
  return {
    serviceUniqueId: memberId,
    requestSource: 'raw-member',
    rawData: getSourceMember(memberId),
    timestamp: moment().toDate(),
  };
};

export const getSourceMember = (testMemberId?: string): RegTypes.SourceData.ISourceMember => {
  const memberId = testMemberId ? testMemberId : uuid();
  return {
    id: memberId,
    legacy_user_id: '99999999992419776',
    email: `${memberId}@core_test.com`,
    encrypted_password: '$2a$10$w4kae/E7xBXLAETPOnXn.eYAouF3B.Z9/lWGNsI1SxRrIQdZhQFdS',
    username: `userName_${memberId}`,
    salutation: null,
    first_name: `firstName_${memberId}`,
    middle_name: null,
    last_name: `lastName_${memberId}`,
    fiance_salutation: null,
    fiance_first_name: `fianceFirstName_${memberId}`,
    fiance_middle_name: null,
    fiance_last_name: `fianceLastName_${memberId}`,
    fiance_email: `${memberId}@core_test2.com`,
    wedding_date: moment().add(7, 'm').format('YYYY-MM-DD'),
    created_at: moment().toISOString(),
    updated_at: moment().toISOString(),
    wedding_city: null,
    wedding_state: null,
    brand: 'theknot',
    status: 'active',
    created_by: null,
    modified_by: null,
    deactivated_at: null,
    engagement_date: null,
    addresses: [
      {
        id: 'e2ceb0bc-6878-4e44-bb77-ac1a286fa5e7',
        city: 'Houston',
        state: 'TX',
        address_1: null,
        address_2: null,
        zip: '77022',
        address_type: 'wedding',
        verified: true,
        created_by: null,
        modified_by: null,
        country_code: 'USA',
        address_status_date: null,
        address_status: null,
        created_at: '2017-06-25T20:42:09.346Z',
        updated_at: '2017-09-05T00:29:23.574Z',
        market_code: 'LNS',
        state_name: 'Texas',
      },
      {
        id: 'a3bb6991-2755-444b-8d7f-bb543643d556',
        city: 'Philadelphia',
        state: 'PA',
        address_1: null,
        address_2: null,
        zip: '19107',
        address_type: 'account_create',
        verified: true,
        created_by: null,
        modified_by: null,
        country_code: 'US',
        address_status_date: null,
        address_status: null,
        created_at: '2017-06-25T20:42:09.348Z',
        updated_at: '2017-09-05T00:29:23.577Z',
        market_code: '021',
        state_name: 'Pennsylvania',
      },
    ],
  };
};

export { basicSourceData, rawRegistrySourceData, requestSource, rawRetailerRegistry };
