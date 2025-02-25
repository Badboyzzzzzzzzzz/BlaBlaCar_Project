import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/dummy_data/dummy_data.dart';
import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/widgets/display/bla_divider.dart';

class LocationPickerScreen extends StatefulWidget {
  final String? initialQuery;
  // Constructor accepts an optional initial query to pre-populate the search field
  const LocationPickerScreen({
    super.key,
    this.initialQuery,
  });
  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Location> _filteredLocations = [];
  bool _isSearching =
      false; // Flag to indicate whether the search is in progress
  @override
  void initState() {
    super.initState();
    /// If an initial query is provided, pre-fill the search bar with it
    _searchController.text = widget.initialQuery ?? '';
    /// Add listener to the search controller to trigger the search when the query changes
    _searchController.addListener(_onSearchChanged);

    /// Trigger search if initialQuery is provided
    if (widget.initialQuery?.isNotEmpty ?? false) {
      _onSearchChanged();
    }
  }

  // Handles the search query changes and filters the locations list
  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _isSearching = true; // Start the search process (show loading indicator)
      // Filter locations based on the query (search in location name or country name)
      _filteredLocations = fakeLocations.where((location) {
        return location.name.toLowerCase().contains(
                query) || // Use contains for broader search (any part of the name)
            location.country.name.toLowerCase().contains(query);
      }).toList();

      // Sort filtered locations alphabetically by their name
      _filteredLocations
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      _isSearching = false; // Finished searching, hide loading indicator
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BlaColors.white,
        leading: IconButton(
          // Back button in the app bar
          icon: Icon(Icons.chevron_left_sharp, color: BlaColors.neutralLight),
          onPressed: () => Navigator.pop(
              context), // Pop the current screen from the navigation stack
        ),
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search for a location',
            border: InputBorder.none,
          ),
          style: BlaTextStyles.body.copyWith(color: BlaColors.neutralDark),
          autofocus:
              true, // Automatically focus on the search field when the screen is displayed
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: BlaColors.neutralLight),
            onPressed: () {
              if (_searchController.text.isEmpty) {
                Navigator.pop(context);
              } else {
                _searchController.clear();
              }
            },
          ),
        ],
      ),
      body: _isSearching
          ? Center(
              child: CircularProgressIndicator(),
            ) // Show loading indicator while searching
          : _searchController.text.isEmpty
              ? Center(
                  // Show a placeholder message when the search field is empty
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Start typing to search for a location',
                      style: TextStyle(
                        color: BlaColors.neutralLight,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: _filteredLocations.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'No locations found',
                              style: TextStyle(
                                color: BlaColors.neutralLight,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: _filteredLocations.length,
                          separatorBuilder: (context, index) {
                            return BlaDivider(); // Insert BlaDivider between list items
                          },
                          itemBuilder: (context, index) {
                            final location = _filteredLocations[index];
                            return ListTile(
                              leading: index < 3
                                  ? Icon(Icons.schedule,
                                      color: BlaColors.neutralLight)
                                  : null, // Display an icon for the first 3 items in the list
                              title: Text(
                                location.name, // Display the location name
                                style: BlaTextStyles.body.copyWith(
                                  color: BlaColors.textNormal,
                                ),
                              ),
                              subtitle: Text(
                                location.country
                                    .name, // Display the country of the location
                                style: TextStyle(
                                  fontSize: 14,
                                  color: BlaColors
                                      .neutralDark, // Lighter color for the subtitle
                                ),
                              ),
                              trailing: Icon(
                                Icons.chevron_right,
                                color: BlaColors.neutralDark,
                              ), // Right chevron icon for navigation
                              onTap: () => Navigator.pop(context,
                                  location), // On tap, pass the selected location back
                            );
                          },
                        ),
                ),
    );
  }
}
