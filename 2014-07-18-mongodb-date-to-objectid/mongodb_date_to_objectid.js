var dateToObjectId = function(date) {
  return new ObjectId(
    (date.getTime() / 1000).toString(16) + "0000000000000000"
  );
};

t0 = dateToObjectId(new Date(2014,(07-1),18,00,00,00));
t1 = dateToObjectId(new Date(2014,(07-1),18,06,00,00));

db.COLLECTION.find({_id: { $gte : t0, $lt : t1 }}).count();