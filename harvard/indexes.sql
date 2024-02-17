CREATE INDEX "enrollments_index" ON "enrollments" ("course_id", "student_id");

CREATE INDEX "courses_index" ON "courses" ("department", "number", "semester");

CREATE INDEX "satisfies_index" ON "satisfies" ("course_id");
