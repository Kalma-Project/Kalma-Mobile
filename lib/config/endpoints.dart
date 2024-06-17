const String BASE_URL = 'https://kalma-backend-production.up.railway.app/api/';

// General API Endpoints
const String register_user = 'user/register';
const String login_user = 'user/authenticate';
const String get_refresh_token = 'user/refresh-token';
const String get_user_property = 'user/user-property';
const String update_user_property = 'user/user-property/update';
const String post_reset_password = 'user/forgot-password';

// Self Management API Endpoints
const String post_journaling = 'self-management/journals/users-journal';
const String get_journaling_data = 'self-management/journals/users-journal';
const String get_journaling_data_detail = 'self-management/journals/users-journal/';
const String get_music_data = 'self-management/music-meditation/';
const String get_music_data_detail = 'self-management/music-meditation/';

// Self Screening API Endpoints
const String post_self_screening = 'self-screening/test';
const String get_self_screening = 'self-screening/history';
const String get_self_screening_detail = 'self-screening/history';