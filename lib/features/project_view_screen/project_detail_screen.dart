import 'package:flutter/material.dart';
import 'package:mindframe_user/common_widget/custom_button.dart';
import 'package:mindframe_user/features/my_projects/add_project_screen.dart';
import 'package:mindframe_user/features/project_view_screen/blocs/projects_bloc/projects_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProjectDetailScreen extends StatefulWidget {
  final Map<String, dynamic> projectDetails;
  final ProjectsBloc myProjectBloc;
  const ProjectDetailScreen(
      {super.key, required this.projectDetails, required this.myProjectBloc});

  @override
  _ProjectDetailScreenState createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  @override
  Widget build(BuildContext context) {
    int progressPercentage = 0;
    double progress = 0;
    if (widget.projectDetails['fund_required'] != null) {
      progress = widget.projectDetails['funded_amount'] /
          widget.projectDetails['fund_required'];
      progressPercentage = (progress * 100).round(); // Calculate percentage
    }
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black.withAlpha(200),
            child: IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
              child: Image.network(
                widget.projectDetails['image_url'],
                height: 290,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Project Name and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.projectDetails['title'],
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      widget.projectDetails['city'] +
                          ', ' +
                          widget.projectDetails['district'] +
                          ', ' +
                          widget.projectDetails['state'] +
                          widget.projectDetails['country'],
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Description with Read More/Less
                  Text(
                    widget.projectDetails['description'],
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),

                  const SizedBox(height: 5),

                  if (widget.projectDetails['fund_required'] != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        LinearProgressIndicator(
                          value: progress.clamp(0.0, 1.0),
                          backgroundColor: Colors.grey[800],
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                        const SizedBox(height: 8),
                        // Days to Go and Funded Text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${widget.projectDetails['fund_required']} fund required',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.grey[400]),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '$progressPercentage% funded', // Display percentage
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                  if (Supabase.instance.client.auth.currentUser!.id ==
                      widget.projectDetails['user_id'])
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: CustomButton(
                        inverse: true,
                        backGroundColor: Colors.deepOrange,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => AddProjectScreen(
                                projectDetails: widget.projectDetails,
                                myProjectBloc: widget.myProjectBloc,
                              ),
                            ),
                          );
                        },
                        label: 'Edit Project',
                      ),
                    ),

                  if (Supabase.instance.client.auth.currentUser!.id ==
                      widget.projectDetails['user_id'])
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: CustomButton(
                        inverse: true,
                        backGroundColor: Colors.red,
                        onPressed: () {
                          widget.myProjectBloc.add(DeleteProjectEvent(
                              projectId: widget.projectDetails['id']));
                          Navigator.of(context).pop();
                        },
                        label: 'Delete Project',
                      ),
                    ),

                  if (Supabase.instance.client.auth.currentUser!.id !=
                      widget.projectDetails['user_id'])

                    // Location Chip
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 125,
                          child: CustomButton(
                            onPressed: () {},
                            iconData: Icons.person_add,
                            label: 'Add Collab',
                          ),
                        )
                      ],
                    ),

                  const SizedBox(height: 5),

                  if (widget.projectDetails['user_id'] !=
                      Supabase.instance.client.auth.currentUser!.id)
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: CustomButton(
                        inverse: true,
                        onPressed: () {},
                        label: 'Fund Project',
                      ),
                    ),

                  // Add Review Button
                  // CustomButton(
                  //   onPressed: () {
                  //     showDialog(
                  //       context: context,
                  //       builder: (context) =>
                  //           ReviewDialog(onSubmit: _addReview),
                  //     );
                  //   },
                  //   label: 'Add Feedback',
                  // ),

                  // const SizedBox(height: 20),

                  // User Reviews Section
                  // Text(
                  //   'User Feedbacks',
                  //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  //       color: Colors.black, fontWeight: FontWeight.bold),
                  // ),

                  // Reviews List
                  // ListView.builder(
                  //   padding: const EdgeInsets.all(0),
                  //   shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemCount: reviews.length,
                  //   itemBuilder: (context, index) {
                  //     final review = reviews[index];
                  //     return ListTile(
                  //       leading: const CircleAvatar(
                  //         child: Icon(Icons.person),
                  //       ),
                  //       title: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text(
                  //             review['name'],
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .titleSmall!
                  //                 .copyWith(
                  //                     color: Colors.black,
                  //                     fontWeight: FontWeight.bold),
                  //           ),
                  //         ],
                  //       ),
                  //       subtitle: Text(review['comment']),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewDialog extends StatefulWidget {
  final Function(String, String, double) onSubmit;

  const ReviewDialog({super.key, required this.onSubmit});

  @override
  _ReviewDialogState createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  double _rating = 3.0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Write a Review'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () {
                  setState(() {
                    _rating = index + 1.0;
                  });
                },
              );
            }),
          ),
          TextField(
            controller: _reviewController,
            decoration: const InputDecoration(
              hintText: 'Write your review here...',
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_reviewController.text.isNotEmpty) {
              widget.onSubmit('User', _reviewController.text, _rating);
              Navigator.pop(context);
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
