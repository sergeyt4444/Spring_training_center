package com.project.misc;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class MiscTool {

    public static final Set<String> accesibleByUsersAttrs = Collections.unmodifiableSet(
    new HashSet<String>(Arrays.asList("current participants", "user courses", "courses notified")));

}
