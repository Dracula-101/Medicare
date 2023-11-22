import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:medicare/core/spacings/app_spacing.dart';
import 'package:medicare/data/models/local_medicine/local_medicine.dart';
import 'package:medicare/data/repository/medicine/medicine_repository.dart';
import 'package:medicare/features/app/bloc/app_bloc.dart';
import 'package:medicare/features/home/patient/pages/search/cubit/search_cubit.dart';
import 'package:medicare/theme/app_theme.dart';
import 'package:http/http.dart' as http;
import 'package:medicare/theme/colors.dart';
import 'package:medicare/util/debouncer.dart';

class PatientSearch extends StatelessWidget {
  const PatientSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(
        medicineRepository: GetIt.I.get<MedicineRepository>(),
      ),
      child: const PatientSearchView(),
    );
  }
}

class PatientSearchView extends StatefulWidget {
  const PatientSearchView({super.key});

  @override
  State<PatientSearchView> createState() => _PatientSearchViewState();
}

class _PatientSearchViewState extends State<PatientSearchView> {
  TextEditingController _searchController = TextEditingController();
  Debounce _debouncer = Debounce(Duration(milliseconds: 500));

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    boxShadow: [boxShadow()]),
                child: SvgPicture.asset(
                  'assets/svg/search_background.svg',
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width - 20,
                top: MediaQuery.of(context).size.width / 5,
                child: Text(
                  'Search\n for medicines',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 30,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Container(
                  width: MediaQuery.of(context).size.width - 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.background,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  child: TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for medicines',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      isDense: true,
                      suffixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onChanged: (value) {
                      if (value == "") {
                        context.read<SearchCubit>().resetSearch();
                      } else if (value != "" && value.length > 4) {
                        _debouncer.call(() {
                          context.read<SearchCubit>().searchMedicine(value);
                        });
                      }
                    },
                    onFieldSubmitted: (value) {
                      if (value == "") {
                        context.read<SearchCubit>().resetSearch();
                      } else if (value != "" && value.length > 4) {
                        context.read<SearchCubit>().searchMedicine(value);
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        AppSpacing.verticalSpacing10,
        BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            return state.when(
              initial: () => Container(
                width: MediaQuery.of(context).size.width / 2 + 20,
                margin: const EdgeInsets.only(top: 32),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 32,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Theme.of(context).colorScheme.background,
                  boxShadow: [cardShadow()],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 80,
                      color: AppColors.grey300,
                    ),
                    AppSpacing.verticalSpacing32,
                    Text(
                      'Find your medicines and new products',
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              loading: () => Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 32),
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                  ),
                ),
              ),
              loaded: (result) => Column(
                children: [
                  ...result.data?.map(
                        (e) {
                          return ListTile(
                            leading: e.image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      height: 55,
                                      width: 55,
                                      child: Image.network(
                                        e.image ?? '',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : null,
                            title: Text(e.name ?? ''),
                            subtitle: Text('₹ ${e.price?.mrp ?? ''}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                context
                                    .read<AppBloc>()
                                    .add(AppEvent.addMedicines(medicines: [
                                      LocalMedicine(
                                        medicine: e.name ?? '',
                                        days: [
                                          'Monday',
                                          'Tuesday',
                                          'Wednesday',
                                          'Thursday',
                                          'Friday',
                                          'Saturday',
                                          'Sunday'
                                        ],
                                        isAfternoon: true,
                                        isMorning: true,
                                        isEvening: true,
                                      )
                                    ]));
                              },
                            ),
                          );
                        },
                      ).toList() ??
                      [const SizedBox()]
                ],
              ),
              error: (exception) => const SizedBox(),
            );
          },
        )
      ],
    );
  }
}
