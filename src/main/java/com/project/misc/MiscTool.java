package com.project.misc;

import java.util.*;

public class MiscTool {

    public static final Set<String> accesibleByUsersAttrs = Collections.unmodifiableSet(
    new HashSet<String>(Arrays.asList("current participants", "user courses", "courses notified", "subscribers")));

    public static String removeNumFromStringList(String stringList, int forRemoval) {
        List<String> list = new ArrayList<>();
        list.addAll(Arrays.asList(stringList.split(";")));
        list.remove(Integer.toString(forRemoval));
        StringBuilder result = new StringBuilder();
        for (String elem: list) {
            result.append(elem).append(";");
        }
        return result.toString();
    }

}
