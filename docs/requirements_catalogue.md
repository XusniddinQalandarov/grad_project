# Requirements Catalogue

## 1. Functional Requirements

### FR1: User Authentication
**Description**: The system shall provide role-based authentication allowing users to log in as either a Student or Cook. Authentication shall be managed through Firebase Authentication service. Upon successful authentication, users shall be redirected to role-specific interfaces. The system shall maintain session state and allow users to log out at any time.

**Acceptance Criteria**:
- Users can log in using email and password
- System distinguishes between Student and Cook roles
- Students are redirected to main navigation with 4 tabs (Canteen, Rooms, Schedule, Profile)
- Cooks are redirected to cook-specific interface with 2 tabs (Canteen Management, Profile)
- Session persists across app restarts
- Users can log out successfully

---

### FR2: Canteen Menu Display (Student)
**Description**: Students shall be able to view the daily canteen menu with meal items organized by date. Each menu item shall display name, image, price, calories, description, ingredients, and dietary tags (vegetarian, vegan, healthy, etc.). Students can filter menu items by tags and navigate between different dates using a date selector. Menu items are fetched from Firebase Firestore in real-time.

**Acceptance Criteria**:
- Display menu items for selected date
- Show meal images from Firebase Storage
- Display all meal details (name, price, calories, description, ingredients)
- Filter by dietary tags (vegetarian, vegan, healthy)
- Navigate between dates
- Real-time updates when cooks modify menu

---

### FR3: Canteen Menu Management (Cook)
**Description**: Cooks shall be able to add, edit, and delete menu items. When adding/editing, cooks can upload images via camera or gallery, set meal details (name, price, calories, description, ingredients, tags, availability date, quantity), and upload images to Firebase Storage. Changes shall immediately reflect in student views.

**Acceptance Criteria**:
- Add new menu items with all required fields
- Edit existing menu items
- Delete menu items with confirmation
- Upload images from camera or gallery
- Images stored in Firebase Storage
- Changes sync in real-time to student views

---

### FR4: Available Rooms Display
**Description**: Students shall be able to view available study rooms with information including room number, capacity, equipment available (projector, smart board), and availability status. Rooms are displayed in a list format with clear visual indicators for availability.

**Acceptance Criteria**:
- Display list of available rooms
- Show room number, capacity, and equipment
- Indicate availability status (Available/Occupied)
- Real-time availability updates (when backend is implemented)

---

### FR5: Peer Teaching/Tutoring
**Description**: Students shall be able to browse available peer tutors by subject. Each tutor profile displays name, subject expertise, and rating. Students can view tutor information to make informed decisions about peer learning opportunities.

**Acceptance Criteria**:
- Display list of available tutors
- Show tutor name, subject, and rating
- Filter tutors by subject (when implemented)
- Contact/book tutors (when implemented)

---

### FR6: Class Schedule Management
**Description**: Students shall be able to add, view, and manage their class schedule. Each class session includes name, room, time, day of week, and optional instructor. Students can view schedule filtered by day of week and add new class sessions.

**Acceptance Criteria**:
- Add new class sessions with required fields
- View schedule organized by day of week
- Filter schedule by selected day
- Display class name, time, room, and instructor
- Data persisted in Firebase Firestore

---

### FR7: Assignment Management
**Description**: Students shall be able to create, edit, complete, and delete assignments. Each assignment includes title, associated course, due date, and priority level (high, medium, low). Students can mark assignments as complete by swiping, view pending assignments, and receive visual indicators for priority levels.

**Acceptance Criteria**:
- Add new assignments with title, course, due date, priority
- Edit existing assignments
- Delete assignments with confirmation
- Mark assignments as complete via swipe gesture
- Display pending assignments only
- Visual priority indicators (color-coded)
- Data persisted in Firebase Firestore

---

### FR8: GPA Calculator
**Description**: Students shall be able to add courses with credits and grades, and the system shall automatically calculate GPA. The system supports standard grade scale (A=4.0, A-=3.7, B+=3.3, B=3.0, B-=2.7, C+=2.3, C=2.0, C-=1.7, D=1.0, F=0.0). GPA calculation formula: Sum of (Grade Point × Credits) / Total Credits.

**Acceptance Criteria**:
- Add courses with name, credits, and grade
- Edit course information
- Delete courses
- Automatic GPA calculation displayed prominently
- Support all standard letter grades
- Accurate weighted GPA calculation
- Data persisted in Firebase Firestore

---

### FR9: Profile and Settings
**Description**: Users shall be able to view their profile information (name, email, role) and manage app settings including theme preference (light/dark mode), language settings, and notification preferences. Users can also view app version and access privacy policy and terms of service.

**Acceptance Criteria**:
- Display user profile information
- Toggle between light and dark themes
- Access language settings (UI ready)
- Access notification settings (UI ready)
- View app version
- Access privacy policy and terms of service links
- Logout functionality

---

### FR10: Lost & Found
**Description**: Students shall be able to post lost items with description and images, and browse found items posted by others. Users can mark items as claimed and search/filter items by category. (Note: This feature requires implementation)

**Acceptance Criteria**:
- Post lost items with description and images
- Browse found items
- Search/filter items by category
- Mark items as claimed
- Real-time updates from Firebase

---

## 2. Non-Functional Requirements

### NFR1: Performance
**Description**: The application shall load initial screens within 2 seconds on average network conditions. Images shall be optimized and cached appropriately. Navigation between screens shall be instantaneous (< 100ms). The app shall handle Firebase queries efficiently without blocking the UI thread.

**Metrics**:
- Initial app load: < 2 seconds
- Screen navigation: < 100ms
- Image loading: Progressive loading with placeholders
- Firebase query response: < 1 second for typical queries

---

### NFR2: Usability
**Description**: The application shall follow Material Design 3 guidelines with intuitive navigation. All features shall be accessible within 2-3 taps from the home screen. Error messages shall be user-friendly and provide actionable guidance. The UI shall support both light and dark themes for user preference.

**Metrics**:
- Average task completion rate: > 90%
- User satisfaction score: > 4.0/5.0
- Accessibility: WCAG 2.1 Level AA compliance
- Learnability: New users can complete primary tasks without documentation

---

### NFR3: Reliability
**Description**: The application shall maintain data consistency with Firebase backend. Network failures shall be handled gracefully with appropriate error messages and retry mechanisms. Data shall be persisted locally when possible to support offline functionality. The app crash rate shall be less than 1%.

**Metrics**:
- Uptime: > 99.5%
- Crash-free rate: > 99%
- Data loss incidents: 0
- Network error handling: Graceful degradation with user notification

---

### NFR4: Security
**Description**: User authentication credentials shall be securely handled through Firebase Authentication. User data shall be protected with proper Firestore security rules. Images uploaded to Firebase Storage shall be validated for type and size. Sensitive data shall not be stored in plain text.

**Metrics**:
- Authentication: Firebase Authentication (encrypted)
- Data encryption: Firestore security rules implemented
- Image validation: Type and size checks before upload
- Secure storage: No sensitive data in local storage unencrypted

---

### NFR5: Scalability
**Description**: The application architecture shall support increasing number of users and data. Clean Architecture principles ensure code maintainability. The use of repositories and abstraction layers allows for easy backend changes. Code shall be modular and follow SOLID principles.

**Metrics**:
- Support for 10,000+ concurrent users
- Database queries optimized with indexing
- Code modularity: Features independent and testable
- Maintainability: Code coverage > 70%

---

### NFR6: Portability
**Description**: The application shall run on Android and iOS platforms with a single codebase using Flutter framework. The app shall adapt to different screen sizes and orientations. Platform-specific UI elements shall be used where appropriate (e.g., Material Design for Android, Cupertino for iOS when needed).

**Metrics**:
- Support Android API 21+ (Android 5.0 Lollipop)
- Support iOS 12.0+
- Responsive design: Support phones and tablets
- Screen size adaptation: 4.0" to 7" displays

---

### NFR7: Maintainability
**Description**: Code shall follow Clean Architecture with clear separation of concerns (Domain, Data, Presentation layers). Code shall be well-documented with meaningful variable and function names. Testing shall be implemented at multiple levels (unit, widget, integration). Code generation tools (Freezed, json_serializable) ensure type safety and reduce boilerplate.

**Metrics**:
- Code documentation: All public APIs documented
- Test coverage: > 70%
- Code complexity: Cyclomatic complexity < 10 per function
- Build warnings: 0 critical warnings

---

### NFR8: Compatibility
**Description**: The application shall be compatible with Flutter SDK 3.9.2+ and Dart SDK 3.0+. All dependencies shall be regularly updated for security patches. The app shall support the latest stable versions of Android and iOS.

**Metrics**:
- Flutter SDK: 3.9.2+
- Dart SDK: 3.0+
- Android minimum: API 21 (Android 5.0)
- iOS minimum: 12.0
- Dependency updates: Regular security patches applied

