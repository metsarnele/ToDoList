use mongodb;

db.users.insertMany([
  {
    name: "John Doe",
    email: "john@example.com",
    password_hash: "...",
    created_at: new Date("2024-12-18T00:00:00Z"),
    updated_at: new Date("2024-12-18T00:00:00Z")
  }
]);


db.tags.insertMany([
  { _id: ObjectId("64cfcf2fe4b0e6f3c2f9f001"), name: "Urgent" },
  { _id: ObjectId("64cfcf2fe4b0e6f3c2f9f002"), name: "Work" }
]);


db.tasks.insertMany([
  {
    _id: ObjectId("64cfcf2fe4b0e6f3c2f9f003"),
    user_id: ObjectId("64cfcf2fe4b0e6f3c2f9f123"), // Viide users kollektsiooni
    title: "Complete project",
    description: "Finalize all project requirements",
    status: "pending",
    due_date: new Date("2024-12-25"),
    priority: 3,
    created_at: new Date("2024-12-18"),
    updated_at: new Date("2024-12-18"),
    tags: [ObjectId("64cfcf2fe4b0e6f3c2f9f001"), ObjectId("64cfcf2fe4b0e6f3c2f9f002")] // Viited loodud tagidele
  }
]);

db.tasks_log.insertOne({
  _id: ObjectId("64cfcf2fe4b0e6f3c2f9f004"),
  task_id: ObjectId("64cfcf2fe4b0e6f3c2f9f003"), // Viide ülesandele
  old_status: "pending",
  new_status: "in_progress",
  changed_by: ObjectId("64cfcf2fe4b0e6f3c2f9f123"), // Viide kasutajale
  changed_at: new Date("2024-12-18")
});

db.tasks.insertOne({
  _id: ObjectId("64cfcf2fe4b0e6f3c2f9f005"),
  user_id: ObjectId("64cfcf2fe4b0e6f3c2f9f123"), // Viide olemasolevale kasutajale
  title: "Write documentation",
  description: "Prepare detailed project documentation",
  status: "pending",
  due_date: new Date("2024-12-30"),
  priority: 2, // Medium priority
  created_at: new Date("2024-12-18"),
  updated_at: new Date("2024-12-18"),
  tags: [ObjectId("64cfcf2fe4b0e6f3c2f9f001")] // Viide tagile "Urgent"
});

db.tags.insertOne({
  _id: ObjectId("64cfcf2fe4b0e6f3c2f9f003"),
  name: "Documentation"
});

db.my_collection.find();

db.users.insertMany([
  {
    _id: ObjectId("64cfcf2fe4b0e6f3c2f9f124"),
    name: "Jane Smith",
    email: "jane.smith@example.com",
    password_hash: "hashed_password_for_jane",
    created_at: new Date("2024-12-17T12:00:00Z"),
    updated_at: new Date("2024-12-17T12:00:00Z")
  },
  {
    _id: ObjectId("64cfcf2fe4b0e6f3c2f9f125"),
    name: "Bob Brown",
    email: "bob.brown@example.com",
    password_hash: "hashed_password_for_bob",
    created_at: new Date("2024-12-16T12:00:00Z"),
    updated_at: new Date("2024-12-16T12:00:00Z")
  }
]);

db.tasks.insertMany([
  {
    _id: ObjectId("64cfcf2fe4b0e6f3c2f9f126"),
    user_id: ObjectId("64cfcf2fe4b0e6f3c2f9f124"),
    title: "Write documentation",
    description: "Prepare detailed project documentation",
    status: "in_progress",
    due_date: new Date("2024-12-20"),
    priority: 1,
    created_at: new Date("2024-12-18"),
    updated_at: new Date("2024-12-18"),
    tags: [ObjectId("64cfcf2fe4b0e6f3c2f9f001")]
  },
  {
    _id: ObjectId("64cfcf2fe4b0e6f3c2f9f127"),
    user_id: ObjectId("64cfcf2fe4b0e6f3c2f9f125"),
    title: "Code review",
    description: "Review the latest PRs",
    status: "completed",
    due_date: new Date("2024-12-22"),
    priority: 2,
    created_at: new Date("2024-12-18"),
    updated_at: new Date("2024-12-18"),
    tags: [ObjectId("64cfcf2fe4b0e6f3c2f9f002")]
  }
]);

db.tasks_log.insertMany([
  {
    _id: ObjectId("64cfcf2fe4b0e6f3c2f9f128"),
    task_id: ObjectId("64cfcf2fe4b0e6f3c2f9f126"),
    old_status: "pending",
    new_status: "in_progress",
    changed_by: ObjectId("64cfcf2fe4b0e6f3c2f9f124"),
    changed_at: new Date("2024-12-18T15:00:00Z")
  },
  {
    _id: ObjectId("64cfcf2fe4b0e6f3c2f9f129"),
    task_id: ObjectId("64cfcf2fe4b0e6f3c2f9f127"),
    old_status: "in_progress",
    new_status: "completed",
    changed_by: ObjectId("64cfcf2fe4b0e6f3c2f9f125"),
    changed_at: new Date("2024-12-18T16:00:00Z")
  }
]);
