# UML Activity Diagram

## Overview
This UML Activity Diagram illustrates the complete flow of activities within the University Management Mobile Application. The diagram covers all major user journeys including authentication, canteen management, schedule tracking, rooms/teaching access, and profile management.

## Activity Diagram Description

### Main Application Flow

The application begins with **App Launch** which initializes Firebase and checks authentication state. Based on authentication status, the system branches into two main paths:

#### Path 1: Unauthenticated User
1. **Show Login Screen** → User enters credentials
2. **Validate Credentials** → Firebase Authentication validates
3. **Determine User Role** → System identifies user as Student or Cook
4. **Redirect to Role-Based Interface**

#### Path 2: Authenticated User
1. **Check User Role** → Determine if Student or Cook
2. **Load Role-Specific Interface**

### Student User Activities

#### Canteen Module Flow:
1. **Navigate to Canteen Tab**
2. **Select Date** (default: today)
3. **Fetch Menu Items** from Firebase Firestore
4. **Apply Filters** (optional: vegetarian, vegan, healthy tags)
5. **Display Menu Items** with images, prices, calories
6. **View Item Details** (tap on item) → Show full description, ingredients
7. **Return to Menu List**

#### Rooms & Teaching Module Flow:
1. **Navigate to Rooms & Teaching Tab**
2. **Select Tab** → Available Rooms OR Peer Tutors
   
   **If Rooms Tab:**
   - Fetch available rooms from data source
   - Display rooms with capacity, equipment, status
   - Filter by availability (when implemented)
   
   **If Peer Tutors Tab:**
   - Fetch tutor list from data source
   - Display tutors with subject, rating
   - Filter by subject (when implemented)
   - Contact tutor (when implemented)

#### Schedule Module Flow:
1. **Navigate to Schedule Tab**
2. **Select Sub-tab** → Schedule, Assignments, or GPA
   
   **Schedule Sub-tab:**
   - Select day of week
   - Fetch class sessions for selected day
   - Display classes with time, room, instructor
   - **Add Class** → Enter details → Save to Firebase
   - **Edit/Delete Class** → Update Firebase
   
   **Assignments Sub-tab:**
   - Fetch pending assignments from Firebase
   - Display assignments with due date, priority
   - **Add Assignment** → Enter title, course, due date, priority → Save
   - **Swipe to Complete** → Update assignment status
   - **Swipe to Delete** → Confirm → Delete from Firebase
   - **Edit Assignment** → Update fields → Save
   
   **GPA Sub-tab:**
   - Fetch courses from Firebase
   - Calculate GPA automatically (weighted by credits)
   - Display current GPA prominently
   - **Add Course** → Enter name, credits, grade → Save
   - **Edit/Delete Course** → Update GPA calculation

#### Profile Module Flow:
1. **Navigate to Profile Tab**
2. **View Profile Information** (name, email, role)
3. **Toggle Dark Mode** → Update theme preference
4. **Access Settings** → Language, Notifications
5. **View App Information** → Version, Privacy Policy, Terms
6. **Logout** → Clear session → Return to Login

### Cook User Activities

#### Canteen Management Flow:
1. **Navigate to Cook Canteen Screen**
2. **View Current Menu Items** → Load from Firebase
3. **Select Action:**
   
   **Add Meal:**
   - Tap "Add Meal" button
   - Enter meal details (name, price, calories, description, ingredients, tags)
   - Select availability date
   - **Upload Image** → Choose camera or gallery → Crop/Resize → Upload to Firebase Storage
   - Set quantity available
   - Save to Firebase Firestore
   - **Real-time Sync** → Update appears in student views immediately
   
   **Edit Meal:**
   - Tap on existing meal card
   - Load meal details into form
   - Modify fields as needed
   - Update image (optional)
   - Save changes to Firebase
   
   **Delete Meal:**
   - Long press or tap delete icon
   - Confirm deletion dialog
   - Delete from Firebase Firestore
   - Delete image from Firebase Storage (optional)
   - **Real-time Sync** → Removal reflects in student views

#### Profile Module Flow:
- Same as Student Profile flow

### Data Flow Activities

#### Firebase Operations:
1. **Read Operations:**
   - Authenticate user → Firebase Auth
   - Fetch menu items → Firestore query
   - Fetch class sessions → Firestore query
   - Fetch assignments → Firestore query
   - Fetch courses → Firestore query
   - Load images → Firebase Storage download

2. **Write Operations:**
   - Create menu item → Firestore insert + Storage upload
   - Update menu item → Firestore update + Storage update (if image changed)
   - Delete menu item → Firestore delete + Storage delete
   - Create class session → Firestore insert
   - Update/Delete class session → Firestore update/delete
   - Create assignment → Firestore insert
   - Update/Delete assignment → Firestore update/delete
   - Create course → Firestore insert
   - Update/Delete course → Firestore insert/delete
   - Calculate GPA → Local calculation based on courses

### Error Handling Activities

1. **Network Error** → Display error message → Provide retry option
2. **Authentication Error** → Show error → Return to login
3. **Validation Error** → Highlight invalid fields → Show error message
4. **Image Upload Error** → Display error → Allow retry
5. **Firebase Permission Error** → Log error → Show user-friendly message

### Decision Points in Flow

- **Is User Authenticated?** → Login Screen OR Main Interface
- **User Role?** → Student Interface OR Cook Interface
- **Which Tab Selected?** → Route to appropriate module
- **Which Sub-tab (Schedule)?** → Schedule / Assignments / GPA
- **Add or Edit Mode?** → Load empty form OR Load existing data
- **Image Source?** → Camera OR Gallery
- **Network Available?** → Fetch from Firestore OR Show cached/offline data

## Complete Activity Flow Summary

The entire application flow can be represented as:

**App Start** → **Authentication Check** → **Role-Based Navigation** → 
  - **[Student Path]**: Canteen View → Rooms/Teaching → Schedule/Assignments/GPA → Profile
  - **[Cook Path]**: Canteen Management (CRUD) → Profile

All activities integrate with Firebase for data persistence and real-time synchronization. User interactions trigger state updates through Riverpod providers, which manage the application state and trigger UI rebuilds.

## Key Activities Covered

✅ User Authentication and Role Management  
✅ Canteen Menu Viewing (Student)  
✅ Canteen Menu Management (Cook)  
✅ Room Availability Viewing  
✅ Peer Tutor Browsing  
✅ Class Schedule Management  
✅ Assignment Tracking  
✅ GPA Calculation  
✅ Profile and Settings Management  
✅ Theme Switching  
✅ Real-time Data Synchronization  
✅ Image Upload and Management  
✅ Error Handling and Recovery  

This activity diagram logically describes the activities for the **entire application**, covering all functional modules and user journeys as specified in the requirements.

