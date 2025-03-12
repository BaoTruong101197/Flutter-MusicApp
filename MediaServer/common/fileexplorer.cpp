// #include <iostream>
// #include <filesystem>
// #include "fileexplorer.h"

// namespace usbhub
// {
//     FileExplorer::FileExplorer()
//     {
//     }
//     void FileExplorer::investigate(const std::filesystem::path &folder_path)
//     {
//         _investFolder(folder_path);
//     }
//     void FileExplorer::_investFolder(const std::filesystem::path &folder_path)
//     {
//         if (!std::filesystem::exists(folder_path))
//         {
//             std::cerr << "The path does not exist: " << folder_path << std::endl;
//             return;
//         }

//         {
//             std::shared_lock<std::shared_mutex> lk(m_muxInvestFolder);
//             if (m_investedFolders.insert(folder_path).second == false)
//             {
//                 return;
//             }
//         }

//         for (const auto &entry : std::filesystem::directory_iterator(folder_path))
//         {
//             std::cout << "Name: " << entry.path().filename() << " | ";

//             if (std::filesystem::is_directory(entry))
//             {
//                 std::cout << "Directory";
//                 _investFolder(entry.path()); // can do async
//             }
//             else if (std::filesystem::is_regular_file(entry))
//             {
//                 std::cout << "Regular File";
//             }
//             else if (std::filesystem::is_symlink(entry))
//             {
//                 std::cout << "Symbolic Link";
//             }
//             else
//             {
//                 std::cout << "Other";
//             }
//             std::cout << std::endl;
//         }
//     }

// }