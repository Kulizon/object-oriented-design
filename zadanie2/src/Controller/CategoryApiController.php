<?php

namespace App\Controller;

use App\Entity\Category;
use App\Repository\CategoryRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/api/category')]
class CategoryApiController extends AbstractController
{
    #[Route('', methods: ['GET'])]
    public function index(CategoryRepository $repository): JsonResponse
    {
        $categories = $repository->findAll();
        $data = array_map(fn(Category $c) => $c->toArray(), $categories);
        return $this->json($data);
    }

    #[Route('/{id}', methods: ['GET'], requirements: ['id' => '\d+'])]
    public function show(Category $category): JsonResponse
    {
        return $this->json($category->toArray());
    }

    #[Route('', methods: ['POST'])]
    public function create(Request $request, EntityManagerInterface $em): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $category = new Category();
        $category->setName($data['name'] ?? '');
        $category->setDescription($data['description'] ?? null);

        $em->persist($category);
        $em->flush();

        return $this->json($category->toArray(), Response::HTTP_CREATED);
    }

    #[Route('/{id}', methods: ['PUT'], requirements: ['id' => '\d+'])]
    public function update(Request $request, Category $category, EntityManagerInterface $em): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        if (isset($data['name'])) {
            $category->setName($data['name']);
        }
        if (array_key_exists('description', $data)) {
            $category->setDescription($data['description']);
        }

        $em->flush();

        return $this->json($category->toArray());
    }

    #[Route('/{id}', methods: ['DELETE'], requirements: ['id' => '\d+'])]
    public function delete(Category $category, EntityManagerInterface $em): JsonResponse
    {
        $em->remove($category);
        $em->flush();

        return $this->json(['message' => 'Category deleted']);
    }
}
