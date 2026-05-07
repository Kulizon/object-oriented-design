<?php

namespace App\Controller;

use App\Entity\Order;
use App\Entity\Product;
use App\Repository\OrderRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/api/order')]
class OrderApiController extends AbstractController
{
    private const ROUTE_ID = '/{id}';
    private const ID_REQUIREMENT = ['id' => '\d+'];

    #[Route('', methods: ['GET'])]
    public function index(OrderRepository $repository): JsonResponse
    {
        $orders = $repository->findAll();
        $data = array_map(fn(Order $o) => $o->toArray(), $orders);
        return $this->json($data);
    }

    #[Route(self::ROUTE_ID, methods: ['GET'], requirements: self::ID_REQUIREMENT)]
    public function show(Order $order): JsonResponse
    {
        return $this->json($order->toArray());
    }

    #[Route('', methods: ['POST'])]
    public function create(Request $request, EntityManagerInterface $em): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $order = new Order();
        $order->setCustomerName($data['customer_name'] ?? '');
        if (isset($data['status'])) {
            $order->setStatus($data['status']);
        }

        if (isset($data['product_ids']) && is_array($data['product_ids'])) {
            foreach ($data['product_ids'] as $productId) {
                $product = $em->getRepository(Product::class)->find($productId);
                if ($product) {
                    $order->addProduct($product);
                }
            }
        }

        $order->recalculateTotal();

        $em->persist($order);
        $em->flush();

        return $this->json($order->toArray(), Response::HTTP_CREATED);
    }

    #[Route(self::ROUTE_ID, methods: ['PUT'], requirements: self::ID_REQUIREMENT)]
    public function update(Request $request, Order $order, EntityManagerInterface $em): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        if (isset($data['customer_name'])) {
            $order->setCustomerName($data['customer_name']);
        }
        if (isset($data['status'])) {
            $order->setStatus($data['status']);
        }

        if (isset($data['product_ids']) && is_array($data['product_ids'])) {
            foreach ($order->getProducts()->toArray() as $product) {
                $order->removeProduct($product);
            }
            foreach ($data['product_ids'] as $productId) {
                $product = $em->getRepository(Product::class)->find($productId);
                if ($product) {
                    $order->addProduct($product);
                }
            }
            $order->recalculateTotal();
        }

        $em->flush();

        return $this->json($order->toArray());
    }

    #[Route(self::ROUTE_ID, methods: ['DELETE'], requirements: self::ID_REQUIREMENT)]
    public function delete(Order $order, EntityManagerInterface $em): JsonResponse
    {
        $em->remove($order);
        $em->flush();

        return $this->json(['message' => 'Order deleted']);
    }
}
