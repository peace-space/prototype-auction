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

class AuctionListAdminEvent implements ShouldBroadcastNow
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $auction_list;

    /**
     * Create a new event instance.
     */
    public function __construct($auction_list)
    {
        $this->auction_list = $auction_list;
    }

    /**
     * Get the channels the event should broadcast on.
     *
     * @return array<int, \Illuminate\Broadcasting\Channel>
     */
    public function broadcastOn(): array
    {
        return [
            new Channel('AuctionListAdmin'),
        ];
    }

    public function broadcastWith() {
        try {
            return [
                'status' => 1,
                'message' => 'Successfully.',
                'data' => $this->auction_list
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
