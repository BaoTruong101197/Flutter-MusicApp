// #ifndef _H_FILE_EXPLORER
// #define _H_FILE_EXPLORER

// #include <filesystem>
// #include <unordered_set>
// #include <shared_mutex>

// namespace usbhub
// {
//     class FileExplorer
//     {
//     public:
//         FileExplorer();
//         void investigate(const std::filesystem::path &folder_path);

//     private:
//         void _investFolder(const std::filesystem::path &folder_path);
//         std::unordered_set<std::string> m_investedFolders{};
//         std::shared_mutex m_muxInvestFolder{};
//     };
// }
// #endif //