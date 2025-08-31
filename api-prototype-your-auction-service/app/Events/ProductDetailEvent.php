<?php

namespace App\Events;

use Exception;
use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class ProductDetailEvent implements ShouldBroadcastNow
{
    use Dispatchable, InteractsWithSockets, SerializesModels;
    public $product_detail;
    /**
     * Create a new event instance.
     */
    public function __construct($product_detail)
    {
        $this->product_detail = $product_detail;
    }

    /**
     * Get the channels the event should broadcast on.
     *
     * @return array<int, \Illuminate\Broadcasting\Channel>
     */
    public function broadcastOn(): array
    {
        return [
            new Channel('ProductDetail'),
        ];
    }

    public function broadcastWith() {
        try {
            return [
                'status' => 1,
                'message' => 'Successfully.',
                'data' => $this->product_detail
            ];
        } catch (Exception $e) {
            return [
                'status' => 0,
                'message' => 'Error.',
                'data' => $e
            ];
        }
    }
}
