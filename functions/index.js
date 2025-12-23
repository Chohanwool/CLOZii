const functions = require('firebase-functions/v1');
const admin = require('firebase-admin');

admin.initializeApp();

// Transform function for Algolia Firestore extension.
exports.transformPostForAlgolia = functions
  .region('asia-northeast3')
  .https.onCall((data) => {
  const record = data && typeof data === 'object' && data.data ? data.data : data || {};

  const lat = record.meetingLatitude;
  const lng = record.meetingLongitude;
  if (lat != null && lng != null) {
    record._geoloc = { lat, lng };
  }

  return record;
  });
