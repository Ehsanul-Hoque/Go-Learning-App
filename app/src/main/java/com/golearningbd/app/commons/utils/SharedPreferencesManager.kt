package com.golearningbd.app.commons.utils

import android.content.Context
import android.content.SharedPreferences


class SharedPreferencesManager(context: Context)
{

    companion object {
        const val PREF_NAME = "golearningbd_sharedpref"
    }

    // Field
    private val preferences: SharedPreferences


    init {
        preferences = context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE)
    }


    // Methods to save and get values
    fun saveString(key: String, value: String) {
        preferences.edit().putString(key, value).apply()
    }

    fun getString(key: String, defaultValue: String?): String? {
        return preferences.getString(key, defaultValue)
    }

    /*public void saveInt(String key, int value) {
        preferences.edit().putInt(key, value).apply();
    }

    public int getInt(String key) {
        return preferences.getInt(key, -1);
    }

    public void saveBoolean(String key, boolean value) {
        preferences.edit().putBoolean(key, value).apply();
    }

    public boolean getBoolean(String key) {
        return preferences.getBoolean(key, false);
    }


    // Util method(s)
    public boolean isPresent(String key) {
        return preferences.contains(key);
    }*/

}
