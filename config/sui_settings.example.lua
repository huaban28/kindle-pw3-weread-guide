-- Fresh SimpleUI 3.0.3 installation example; back up existing settings first.
-- Destination: koreader/settings/simpleui/sui_settings.lua
-- Does not contain WeRead login information.
return {
    ["simpleui_qa_list"] = { "custom_qa_1" },
    ["simpleui_qa_custom_qa_1"] = {
        ["label"] = "微信读书",
        ["plugin_key"] = "weread",
        ["plugin_method"] = "openBookshelf",
    },
    ["simpleui_bar_tabs"] = {
        "homescreen", "custom_qa_1", "home", "history", "sui_settings",
    },
}
