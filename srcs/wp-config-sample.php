<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'root' );

/** MySQL database password */
define( 'DB_PASSWORD', '' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '&1b&1%3,@jXi>C-qkD+)p Y!e7i}8[Xpj!s?uP,~l&uhp&|)DG_;:I*hWzsugr/C');
define('SECURE_AUTH_KEY',  'g?rJVe?E0:ZyWW+m$gvx7;r+CQ6+[YnXtkuI>dY^Mq)DHs7utBw/mWi:)|Xn,F=E');
define('LOGGED_IN_KEY',    '#WKIbH8+BB%J+$_ECc~XBsX,hcm87e R>G84p(g,&;FZ*LGroXdd`n&ekB6i5++N');
define('NONCE_KEY',        'B^P<yo]{_[>#Yq~>|ej;Djg]5Smo{+A5aOT@u/yiSJN:<]PpEg-EkwJ1}|dWAm9~');
define('AUTH_SALT',        'Mr`49U_uhKz;ET6vY#&^S]v4ig2Q;|y{j$,wg,DR|d*OD{K^Y^TvBuhLac>S;jzp');
define('SECURE_AUTH_SALT', ';Oeu9DI:+O]bT|]wo&bQQJU-f-?XNQW*qA9Vt@1C$m;XDYFug8hg>9vE?Zd=C`u+');
define('LOGGED_IN_SALT',   '+o`jO[^^eK1|oUWBOA?)m~Oa_||92[bH?!e^-r]RvA{f%`nwWs1%WQOWvvpj4;wO');
define('NONCE_SALT',       '&Yv*@6)w3C+( 9I1C+:&wVY]AdY8-[3r6P?{9t+oscH1>>fGsc]2m|~}Sy:wfvl`');
/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
