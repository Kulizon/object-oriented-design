<?php

namespace App\Controller;

use App\Entity\Product;
use App\Entity\Category;
use App\Entity\Order;
use App\Repository\ProductRepository;
use App\Repository\CategoryRepository;
use App\Repository\OrderRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/admin')]
class AdminController extends AbstractController
{
    #[Route('', methods: ['GET'])]
    public function dashboard(
        ProductRepository $productRepository,
        CategoryRepository $categoryRepository,
        OrderRepository $orderRepository
    ): Response {
        return $this->render('admin/dashboard.html.twig', [
            'product_count' => count($productRepository->findAll()),
            'category_count' => count($categoryRepository->findAll()),
            'order_count' => count($orderRepository->findAll()),
        ]);
    }

    #[Route('/products', methods: ['GET'])]
    public function products(ProductRepository $repository): Response
    {
        return $this->render('admin/products.html.twig', [
            'products' => $repository->findAll(),
        ]);
    }

    #[Route('/product/{id}/delete', methods: ['POST'], requirements: ['id' => '\d+'])]
    public function deleteProduct(Product $product, EntityManagerInterface $em): Response
    {
        $em->remove($product);
        $em->flush();
        return $this->redirectToRoute('app_admin_products');
    }

    #[Route('/product/{id}/edit', methods: ['GET', 'POST'], requirements: ['id' => '\d+'])]
    public function editProduct(Request $request, Product $product, EntityManagerInterface $em, CategoryRepository $categoryRepository): Response
    {
        if ($request->isMethod('POST')) {
            $product->setName($request->request->get('name'));
            $product->setDescription($request->request->get('description'));
            $product->setPrice((float)$request->request->get('price'));

            $categoryId = $request->request->get('category_id');
            if ($categoryId) {
                $product->setCategory($categoryRepository->find($categoryId));
            } else {
                $product->setCategory(null);
            }

            $em->flush();
            return $this->redirectToRoute('app_admin_products');
        }

        return $this->render('admin/edit_product.html.twig', [
            'product' => $product,
            'categories' => $categoryRepository->findAll(),
        ]);
    }

    #[Route('/categories', methods: ['GET'])]
    public function categories(CategoryRepository $repository): Response
    {
        return $this->render('admin/categories.html.twig', [
            'categories' => $repository->findAll(),
        ]);
    }

    #[Route('/category/{id}/delete', methods: ['POST'], requirements: ['id' => '\d+'])]
    public function deleteCategory(Category $category, EntityManagerInterface $em): Response
    {
        $em->remove($category);
        $em->flush();
        return $this->redirectToRoute('app_admin_categories');
    }

    #[Route('/category/{id}/edit', methods: ['GET', 'POST'], requirements: ['id' => '\d+'])]
    public function editCategory(Request $request, Category $category, EntityManagerInterface $em): Response
    {
        if ($request->isMethod('POST')) {
            $category->setName($request->request->get('name'));
            $category->setDescription($request->request->get('description'));

            $em->flush();
            return $this->redirectToRoute('app_admin_categories');
        }

        return $this->render('admin/edit_category.html.twig', [
            'category' => $category,
        ]);
    }

    #[Route('/orders', methods: ['GET'])]
    public function orders(OrderRepository $repository): Response
    {
        return $this->render('admin/orders.html.twig', [
            'orders' => $repository->findAll(),
        ]);
    }

    #[Route('/order/{id}/delete', methods: ['POST'], requirements: ['id' => '\d+'])]
    public function deleteOrder(Order $order, EntityManagerInterface $em): Response
    {
        $em->remove($order);
        $em->flush();
        return $this->redirectToRoute('app_admin_orders');
    }

    #[Route('/order/{id}/edit', methods: ['GET', 'POST'], requirements: ['id' => '\d+'])]
    public function editOrder(Request $request, Order $order, EntityManagerInterface $em, ProductRepository $productRepository): Response
    {
        if ($request->isMethod('POST')) {
            $order->setCustomerName($request->request->get('customer_name'));
            $order->setStatus($request->request->get('status'));

            foreach ($order->getProducts()->toArray() as $product) {
                $order->removeProduct($product);
            }

            $productIds = $request->request->all('product_ids');
            if ($productIds) {
                foreach ($productIds as $productId) {
                    $product = $productRepository->find($productId);
                    if ($product) {
                        $order->addProduct($product);
                    }
                }
            }

            $order->recalculateTotal();
            $em->flush();

            return $this->redirectToRoute('app_admin_orders');
        }

        return $this->render('admin/edit_order.html.twig', [
            'order' => $order,
            'products' => $productRepository->findAll(),
        ]);
    }
}
