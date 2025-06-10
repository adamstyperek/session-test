<?php

namespace App\Controller;

use App\Repository\MovieRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/movies')]
class MovieController extends AbstractController
{
    #[Route('/', name: 'app_movie_index', methods: ['GET'])]
    public function index(MovieRepository $movieRepository, Request $request): Response
    {
        $start = hrtime(true);
// ... your code ...

        $session = $request->getSession();

        // Add a key-value pair to the session
        $session->set('my_key', 'my_value');
        $this->addFlash('notice', 'Welcome to the homepage!');
        $end = hrtime(true);
        $duration = ($end - $start) / 1e6; // Convert nanoseconds to milliseconds
        return $this->render('movie/index.html.twig', [
            'movies' => $movieRepository->findAll(),
            'duration' => $duration
        ]);
    }

    #[Route('/top-rated', name: 'app_movie_top_rated', methods: ['GET'])]
    public function topRated(MovieRepository $movieRepository): Response
    {
        return $this->render('movie/index.html.twig', [
            'movies' => $movieRepository->findTopRated(),
            'title' => 'Top Rated Movies'
        ]);
    }

    #[Route('/genre/{genre}', name: 'app_movie_by_genre', methods: ['GET'])]
    public function byGenre(string $genre, MovieRepository $movieRepository): Response
    {
        return $this->render('movie/index.html.twig', [
            'movies' => $movieRepository->findByGenre($genre),
            'title' => "Movies in {$genre}"
        ]);
    }

    #[Route('/year/{start}/{end}', name: 'app_movie_by_year_range', methods: ['GET'])]
    public function byYearRange(int $start, int $end, MovieRepository $movieRepository): Response
    {
        return $this->render('movie/index.html.twig', [
            'movies' => $movieRepository->findByYearRange($start, $end),
            'title' => "Movies from {$start} to {$end}"
        ]);
    }
} 