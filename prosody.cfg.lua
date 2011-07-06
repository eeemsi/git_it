-- Configuration imported from ejabberd --                                                                             
--Host "*";
--enabled = true;
        modules_enabled = {
                "saslauth"; -- Authentication for clients and servers. Recommended if you want to log in.
--              "legacyauth"; -- Legacy authentication. Only used by some old clients and bots.
                "roster"; -- Allow users to have a roster. Recommended ;)
                "register"; -- Allow users to register on this server using a client
                "tls"; -- Add support for secure TLS on c2s/s2s connections
--              "vcard"; -- Allow users to set vCards
--              "private"; -- Private XML storage (for room bookmarks, etc.)
--              "version"; -- Replies to server version requests
                "dialback"; -- s2s dialback support
--              "uptime";
--              "disco";
--              "time";
--              "ping";
                --"selftests";
                "message";
                "posix";
                "compression";
        };

allow_registration = false;
authentication = "internal_hashed";
admins = {"me@onthismachine"};

use_libevent = true;
c2s_require_encryption = true;
ssl = {
        key = "/etc/prosody/certs/localhost.key";
        certificate = "/etc/prosody/certs/localhost.cert";
};

daemonize = true;
pidfile = "/var/run/prosody/prosody.pid"

log = {
        info = "prosody.log"; -- Change 'info' to 'debug' for verbose logging
        error = "prosody.err";
        "*syslog"; -- Uncomment this for logging to syslog
        -- "*console"; -- Log to the console, useful for debugging with daemonize=false
}


Host "onthismachine";
Host "localhost";
