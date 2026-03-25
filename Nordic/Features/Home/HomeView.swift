import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var favoritesStore: FavoritesStore
    @StateObject private var viewModel = HomeViewModel()

    @State private var selectedGenreId: Int = 0
    @State private var selectedSection: HomeSection? = nil

    private let genres: [Genre] = [
        Genre(id: 0, name: "All"),
        Genre(id: 1, name: "Adventure"),
        Genre(id: 2, name: "Comedy"),
        Genre(id: 3, name: "Fantasy"),
        Genre(id: 4, name: "Drama")
    ]

    private func items(for section: HomeSection) -> [MediaItem] {
        switch section {
        case .new:
            return viewModel.trendingMovies.map(mapToMediaItem)
        case .movies:
            return viewModel.popularMovies.map(mapToMediaItem)
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color("AppBackground").ignoresSafeArea()

                content
            }
            .task {
                await viewModel.load()
                registerLoadedMovies()
            }
            .navigationDestination(for: MediaItem.self) { item in
                DetailView(item: item)
            }
            .navigationDestination(item: $selectedSection) { section in
                SeeAllView(title: section.title, items: items(for: section))
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView()
                .tint(Color("AppTextPrimary"))
        } else if let errorMessage = viewModel.errorMesage {
            VStack(spacing: 12) {
                Text("Something went wrong")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color("AppTextPrimary"))

                Text(errorMessage)
                    .font(.system(size: 14))
                    .foregroundStyle(Color("AppSecondary"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
            }
        } else {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    HStack {
                        Text("Discover")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(Color("AppTextPrimary"))
                        Spacer()
                    }
                    .padding(.top, 6)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(genres) { genre in
                                GenreChipView(
                                    title: genre.name,
                                    isSelected: selectedGenreId == genre.id
                                ) {
                                    selectedGenreId = genre.id
                                }
                            }
                        }
                        .padding(.horizontal, 2)
                    }

                    TabView {
                        ForEach(viewModel.trendingMovies.prefix(5)) { movie in
                            NavigationLink(value: mapToMediaItem(movie)) {
                                HeroBannerView(title: movie.title)
                                    .padding(.horizontal, 2)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .frame(height: 190)
                    .tabViewStyle(.page(indexDisplayMode: .automatic))

                    SectionHeaderView(title: "New") {
                        selectedSection = .new
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(viewModel.trendingMovies.prefix(10)) { movie in
                                NavigationLink(value: mapToMediaItem(movie)) {
                                    TMDBPosterCardView(movie: movie)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }

                    SectionHeaderView(title: "Movies") {
                        selectedSection = .movies
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(viewModel.popularMovies.prefix(10)) { movie in
                                NavigationLink(value: mapToMediaItem(movie)) {
                                    TMDBPosterCardView(movie: movie)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }

                    Spacer()
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 20)
                .navigationTitle("")
                .toolbarVisibility(.hidden)
            }
        }
    }

    private func registerLoadedMovies() {
        let allItems = (viewModel.trendingMovies + viewModel.popularMovies).map(mapToMediaItem)
        favoritesStore.register(allItems)
    }

    private func mapToMediaItem(_ movie: TMDBMovieDTO) -> MediaItem {
        MediaItem(
            id: movie.id,
            title: movie.title,
            year: releaseYear(from: movie.releaseDate),
            rating: movie.voteAverage,
            genreIds: [],
            type: .movie
        )
    }

    private func releaseYear(from releaseDate: String?) -> String {
        guard let releaseDate,
              releaseDate.count >= 4 else {
            return "—"
        }

        return String(releaseDate.prefix(4))
    }
}

private struct HeroBannerView: View {
    let title: String

    var body: some View {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
            .fill(Color.white.opacity(0.10))
            .overlay(
                HStack {
                    Text(title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(Color("AppTextPrimary"))
                        .padding()
                    Spacer()
                }
            )
    }
}
